//
//  FeedDetailDeleteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/01.
//

import Foundation
import RxSwift
import RxCocoa

protocol sendDeleteReviewDelegate {
    func sendDeleteReview()
}

final class FeedDetailDeleteViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private let characterDetailUseCase: CharacterDetailUseCase
    private var review: ReviewList
    var delegate: sendDeleteReviewDelegate?
    
    struct Input{
        let okButtonTapped: ControlEvent<Void>
        let cancelButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        
    }
    
    let deleteReview = PublishRelay<DeleteReview>()
    
    init(coordinator: TabmanCoordinator?, characterDetailUseCase: CharacterDetailUseCase, review: ReviewList) {
        self.coordinator = coordinator
        self.characterDetailUseCase = characterDetailUseCase
        self.review = review
    }
    
    func transform(input: Input) -> Output {
        input.okButtonTapped.bind { [weak self] _ in
            guard let self = self else { return}
            deleteReview(user_id: review.user_id, character_id: review.character_id, review_id: review.review_id)
        }
        .disposed(by: disposeBag)
        
        self.deleteReview
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.dismissViewController()
                vm.delegate?.sendDeleteReview()
            }
            .disposed(by: disposeBag)
        
        input.cancelButtonTapped
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
            guard let self = self else { return}
            self.coordinator?.dismissViewController()
        }
        .disposed(by: disposeBag)
        
        return Output()
    }
}

extension FeedDetailDeleteViewModel {
    private func deleteReview(user_id: String, character_id: Int , review_id: Int) {
        Task {
            let deleteReview = try await characterDetailUseCase.excuteDeleteReview(query: DeleteReviewQuery(user_id: user_id, character_id: character_id, review_id: review_id))
            print(deleteReview, "🍊 리뷰 삭제")
            self.deleteReview.accept(deleteReview)
        }
    }
}
