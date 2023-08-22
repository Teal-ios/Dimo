//
//  RecommendViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/09.
//

import Foundation
import RxSwift
import RxCocoa

enum RecommendCategory: String {
    case random
    case popular
}

final class RecommendViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?
    private var voteUseCase: VoteUseCase
    var category = BehaviorRelay(value: RecommendCategory.random.rawValue)

    init(coordinator: VoteCoordinator?, voteUseCase: VoteUseCase, category: RecommendCategory.RawValue) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
        self.category = BehaviorRelay(value: category)
    }
    
    struct Input{
        let viewDidLoad: PublishRelay<Void>
        let randomButtonTap: ControlEvent<Void>
        let popularButtonTap: ControlEvent<Void>
        let categoryButtonTap: ControlEvent<Void>
    }
    
    struct Output{
        let popularCharacterRecommend: PublishRelay<PopularCharacterRecommendList>
        let randomCharacterRecommend: PublishRelay<RandomCharacterRecommendList>
        let randomButtonTap: ControlEvent<Void>
        let popularButtonTap: ControlEvent<Void>
        let categoryButtonTap: ControlEvent<Void>
        let recommendCategory: PublishRelay<String>
    }
    
    let popularCharacterRecommend = PublishRelay<PopularCharacterRecommendList>()
    let randomCharacterRecommend = PublishRelay<RandomCharacterRecommendList>()
    let recommendCategory = PublishRelay<String>()
    func transform(input: Input) -> Output {
        
//        input.viewDidLoad
//            .withUnretained(self)
//            .bind { vm, _ in
//                guard let user_id = UserDefaultManager.userId else { return }
//                vm.getRandomCharacterRecommend(user_id: user_id)
//            }
//            .disposed(by: disposeBag)
        
        input.viewDidLoad
            .withLatestFrom(self.category)
            .bind { [weak self] category in
                guard let self = self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                self.recommendCategory.accept(category)
                if category == RecommendCategory.random.rawValue {
                    self.getRandomCharacterRecommend(user_id: user_id)
                } else {
                    self.getPopularCharacterRecommend(user_id: user_id)
                }
            }
            .disposed(by: disposeBag)
        
        input.randomButtonTap
            .withUnretained(self)
            .bind { vm, _ in
                guard let user_id = UserDefaultManager.userId else { return }
                vm.getRandomCharacterRecommend(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        input.popularButtonTap
            .withUnretained(self)
            .bind { vm, _ in
                guard let user_id = UserDefaultManager.userId else { return }
                vm.getPopularCharacterRecommend(user_id: user_id)
            }
            .disposed(by: disposeBag)
        
        return Output(popularCharacterRecommend: self.popularCharacterRecommend, randomCharacterRecommend: self.randomCharacterRecommend, randomButtonTap: input.randomButtonTap, popularButtonTap: input.popularButtonTap, categoryButtonTap: input.categoryButtonTap, recommendCategory: self.recommendCategory)
    }
}

extension RecommendViewModel {
    private func getPopularCharacterRecommend(user_id: String) {
        Task {
            let query = PopularCharacterRecommendListQuery(user_id: user_id)
            let popularCharacterRecommend = try await voteUseCase.excutePopularCharacterRecommendList(query: query)
            print(popularCharacterRecommend, "인기순 추천")
            self.popularCharacterRecommend.accept(popularCharacterRecommend)
        }
    }
}

extension RecommendViewModel {
    private func getRandomCharacterRecommend(user_id: String) {
        Task {
            let query = RandomCharacterRecommendQuery(user_id: user_id)
            let randomCharacterRecommend = try await voteUseCase.excuteRandomCharacterRecommend(query: query)
            print(randomCharacterRecommend, "랜덤 추천")
            self.randomCharacterRecommend.accept(randomCharacterRecommend)
        }
    }
}
