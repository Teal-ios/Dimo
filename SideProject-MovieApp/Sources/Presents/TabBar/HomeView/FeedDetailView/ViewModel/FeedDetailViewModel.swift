//
//  FeedDetailViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedDetailViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    
    struct Input{
        let plusNavigationButtonTapped: PublishSubject<Void>
        
    }
    
    struct Output{
    }
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.plusNavigationButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showFeedDetailMoreMyViewMController()
        }
        .disposed(by: disposeBag)
        
        return Output()
    }
}
