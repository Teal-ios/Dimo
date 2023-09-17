//
//  FeedDetailHideUserAlertViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//


import Foundation
import RxSwift
import RxCocoa

final class FeedDetailHideUserAlertViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private var characterDetailUseCase: CharacterDetailUseCase
    private var review_id: Int
    
    struct Input{
        let okButtonTapped: ControlEvent<Void>
        let cancelButtonTapped: ControlEvent<Void>
        let backgroundButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        
    }
    
    let blindUser = PublishRelay<BlindReview>()
    
    init(coordinator: TabmanCoordinator?, characterDetailUseCase: CharacterDetailUseCase, review_id: Int) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.review_id = review_id
    }
    
    func transform(input: Input) -> Output {
        input.okButtonTapped.bind { [weak self] _ in
            guard let self = self else { return}
            guard let user_id = UserDefaultManager.userId else { return }
            self.postBlindUser(user_id: user_id, review_id: review_id)
        }
        .disposed(by: disposeBag)
        
        input.cancelButtonTapped.bind { [weak self] _ in
            guard let self = self else { return}
            self.coordinator?.dismissViewController()
        }
        .disposed(by: disposeBag)
        
        input.backgroundButtonTapped
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.dismissViewController()
            }
            .disposed(by: disposeBag)
        
        self.blindUser
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.dismissViewController()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}

extension FeedDetailHideUserAlertViewModel {
    func postBlindUser(user_id: String, review_id: Int) {
        Task {
            let query = PostBlindReviewQuery(user_id: user_id, review_id: review_id, blind_type: 1)
            let blindUser = try await characterDetailUseCase.excuteBlindReview(query: query)
            print(blindUser, "유저 가리기")
            self.blindUser.accept(blindUser)
        }
    }
}
