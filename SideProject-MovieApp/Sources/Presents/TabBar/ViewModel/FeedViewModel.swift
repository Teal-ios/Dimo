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
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    
    struct Input{


    }
    
    struct Output{
    }
    
    init(coordinator: HomeCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {

        return Output()
    }
}
