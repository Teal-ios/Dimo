//
//  MovieDetailRankViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/26.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailRankViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    
    struct Input{
        let backgroundButtonTapped: ControlEvent<Void>

    }
    
    struct Output{
    }
    
    init(coordinator: HomeCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.backgroundButtonTapped.bind { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }
        .disposed(by: disposeBag)
        
        return Output()
    }
}
