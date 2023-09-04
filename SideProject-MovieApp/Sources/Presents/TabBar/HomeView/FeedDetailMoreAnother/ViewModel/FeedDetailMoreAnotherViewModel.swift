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
    }
    
    struct Output{
    }
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
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
            self.coordinator?.showReportViewController()
        }.disposed(by: disposeBag)
        
        input.allReviewBlindButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
            self.coordinator?.showFeedDetailHideUserAlertViewController()
        }.disposed(by: disposeBag)
        
        return Output()
    }
}
