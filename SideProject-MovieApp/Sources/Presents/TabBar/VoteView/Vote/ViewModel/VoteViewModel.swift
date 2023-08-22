//
//  VoteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import Foundation
import RxSwift
import RxCocoa

final class VoteViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?
    private let voteUseCase: VoteUseCase

    init(coordinator: VoteCoordinator?, voteUseCase: VoteUseCase) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
    }
    
    struct Input{
        let characterRandomRecommandCellTapped: PublishSubject<Void>
        let characterSearchCellTapped: PublishSubject<Void>
        let viewDidLoad: PublishRelay<Void>
        let characterCellTapped: PublishRelay<CharacterInfo>
    }
    
    struct Output{
        let popularCharacterRecommend: PublishRelay<PopularCharacterRecommendList>
    }
    
    let popularCharacterRecommend = PublishRelay<PopularCharacterRecommendList>()
    
    func transform(input: Input) -> Output {
        input.characterRandomRecommandCellTapped.bind { [weak self] _ in
            guard let self else { return }
            print("이건울리니")
            self.coordinator?.showRecommendViewController()
        }
        .disposed(by: disposeBag)
        
        input.characterSearchCellTapped.bind { [weak self] _ in
            guard let self else { return }
            print("이건울리니")
            self.coordinator?.showSearchViewController()
        }
        .disposed(by: disposeBag)
        
        input.viewDidLoad
            .withUnretained(self)
            .bind { vm, _ in
                guard let user_id = UserDefaultManager.userId else { return }
                vm.getPopularCharacterRecommend(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        input.characterCellTapped
            .withUnretained(self)
            .bind { vc, characterInfo in
                if characterInfo.is_vote == 1 {
                    vc.coordinator?.showVoteCompleteViewController(characterInfo: characterInfo)
                } else {
                    vc.coordinator?.showDigViewController(characterInfo: characterInfo)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(popularCharacterRecommend: self.popularCharacterRecommend)
    }
}

extension VoteViewModel {
    private func getPopularCharacterRecommend(user_id: String) {
        Task {
            let query = PopularCharacterRecommendListQuery(user_id: user_id)
            let popularCharacterRecommend = try await voteUseCase.excutePopularCharacterRecommendList(query: query)
            print(popularCharacterRecommend, "인기순 추천")
            self.popularCharacterRecommend.accept(popularCharacterRecommend)
        }
    }
}

