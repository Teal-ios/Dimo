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
    
    struct Input{
        let reviewCellSelected: PublishSubject<Void>
        let writeButtonTapped: ControlEvent<Void>

    }
    
    struct Output{
    }
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
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
        
        return Output()
    }
}
