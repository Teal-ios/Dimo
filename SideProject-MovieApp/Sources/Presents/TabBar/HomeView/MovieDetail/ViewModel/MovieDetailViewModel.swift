//
//  MovieDetailViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDetailViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    
    struct Input{
        let plusButtonTapped: ControlEvent<Void>

    }
    
    struct Output{
        let plusButtonTapped: ControlEvent<Void>

    }
    
    init(coordinator: HomeCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {

        return Output(plusButtonTapped: input.plusButtonTapped)
    }
}
