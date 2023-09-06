//
//  FeedDetailMoreAnotherViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedDetailMoreAnotherViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    
    struct Input{
        let reviewBlindButtonTapped: ControlEvent<Void>
        let reportButtonTapped: ControlEvent<Void>
        let allReviewBlindButtonTapped: ControlEvent<Void>
        let backgroundButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
    }
    
    private var user_id: String
    private var review_id: Int
    
    init(coordinator: TabmanCoordinator?, user_id: String, review_id: Int) {
        self.coordinator = coordinator
        self.user_id = user_id
        self.review_id = review_id
    }
    
    func transform(input: Input) -> Output {
        input.reviewBlindButtonTapped
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.dismissViewController()
                vm.coordinator?.showFeedDetailHideReviewAlertViewController()
            }
            .disposed(by: disposeBag)
        
        input.reportButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
            self.coordinator?.showReportViewController(user_id: self.user_id, review_id: self.review_id)
        }.disposed(by: disposeBag)
        
        input.allReviewBlindButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
            self.coordinator?.showFeedDetailHideUserAlertViewController()
        }.disposed(by: disposeBag)
        
        input.backgroundButtonTapped
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.dismissViewController()
            }
            .disposed(by: disposeBag
            )
        return Output()
    }
}
