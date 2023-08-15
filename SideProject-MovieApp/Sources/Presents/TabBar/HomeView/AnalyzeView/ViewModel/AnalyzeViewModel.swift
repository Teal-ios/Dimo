//
//  AnalyzeViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/06.
//

import Foundation
import RxSwift
import RxCocoa

final class AnalyzeViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: TabmanCoordinator?
    
    struct Input{


    }
    
    struct Output{

    }
    
    init(coordinator: TabmanCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
