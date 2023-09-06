//
//  FeedDetailMoreMyViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedDetailMoreMyViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    private var review: ReviewList
    
    struct Input{
        let modifyButtonTapped: ControlEvent<Void>
        let deleteButtonTapped: ControlEvent<Void>
        let backgroundButtonTapped: ControlEvent<Void>

    }
    
    struct Output{
    }
    
    init(coordinator: TabmanCoordinator?, review: ReviewList) {
        self.coordinator = coordinator
        self.review = review
    }
    
    func transform(input: Input) -> Output {
        input.modifyButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
            self.coordinator?.showModifyWriteViewController(review: self.review)
        }.disposed(by: disposeBag)
        
        input.deleteButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.dismissViewController()
            self.coordinator?.showFeedDetailDeleteViewController(review: self.review)
        }.disposed(by: disposeBag)
        
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
