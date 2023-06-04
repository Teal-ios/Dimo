//
//  WithDrawViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//


import Foundation
import RxCocoa
import RxSwift

class WithDrawViewModel: ViewModelType {
    var disposebag: DisposeBag = DisposeBag()
    
    private weak var coordinator: SettingCoordinator?
    
    struct Input {

    }
    
    struct Output {

    }
    
    
    init(coordinator: SettingCoordinator? = nil) {
        self.coordinator = coordinator
    }
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
