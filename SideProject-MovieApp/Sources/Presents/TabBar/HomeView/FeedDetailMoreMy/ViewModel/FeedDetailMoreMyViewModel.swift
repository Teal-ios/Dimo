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
    
    struct Input{
        let movieButtonTapped: ControlEvent<Void>
        let dramaButtonTapped: ControlEvent<Void>

    }
    
    struct Output{
    }
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.movieButtonTapped.bind { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }.disposed(by: disposeBag)
        
        input.dramaButtonTapped.bind { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }.disposed(by: disposeBag)
        return Output()
    }
}
