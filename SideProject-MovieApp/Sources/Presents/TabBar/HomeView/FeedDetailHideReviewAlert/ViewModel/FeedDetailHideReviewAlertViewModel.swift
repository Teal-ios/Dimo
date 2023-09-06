//
//  FeedDetailHideReviewAlertViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedDetailHideReviewAlertViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    
    struct Input{
        let okButtonTapped: ControlEvent<Void>
        let cancelButtonTapped: ControlEvent<Void>
        let backgroundButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        
    }
    
    
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.okButtonTapped.bind { [weak self] _ in
            guard let self = self else { return}
            self.coordinator?.dismissViewController()
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
        
        return Output()
    }
}
