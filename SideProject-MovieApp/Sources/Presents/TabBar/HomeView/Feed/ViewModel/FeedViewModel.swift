//
//  FeedViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private let characterDetailUseCase: CharacterDetailUseCase
    
    struct Input{
        let reviewCellSelected: PublishSubject<Void>
        let writeButtonTapped: ControlEvent<Void>
        let viewDidLoad: PublishRelay<Void>

    }
    
    struct Output{
        let getReivewList: PublishRelay<GetReview>
    }
    
    init(coordinator: TabmanCoordinator? = nil, characterDetailUseCase: CharacterDetailUseCase, character: Characters?) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.character = BehaviorRelay<Characters?>(value: character)
    }
    
    var character = BehaviorRelay<Characters?>(value: nil)
    let getReivewList = PublishRelay<GetReview>()
    
    func transform(input: Input) -> Output {
        input.reviewCellSelected.bind { [weak self] _ in
            self?.coordinator?.showFeedDetailViewController()
          
        }
        .disposed(by: disposeBag)
        
        input.writeButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.showWriteViewController()
        }
        .disposed(by: disposeBag)
        
        input.viewDidLoad
            .withLatestFrom(self.character)
            .bind { [weak self] character in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                guard let character else { return }
                print(character, "캐릭터조회")
                self.getReviewList(user_id: user_id, character_id: character.character_id)
            }
            .disposed(by: disposeBag)
        
        return Output(getReivewList: self.getReivewList)
    }
}

extension FeedViewModel {
    private func getReviewList(user_id: String, character_id: Int) {
        Task {
            let getReivewList = try await characterDetailUseCase.excuteGetReview(query: GetReviewQuery(user_id: user_id, character_id: character_id))
            print(getReivewList, "리뷰 전체 조회")
            self.getReivewList.accept(getReivewList)
        }
    }
}
