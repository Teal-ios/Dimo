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
    var test: String = ""
    
    struct Input{
        
        
    }
    
    struct Output{
    }
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        print("\(test)")
        return Output()
    }
}
