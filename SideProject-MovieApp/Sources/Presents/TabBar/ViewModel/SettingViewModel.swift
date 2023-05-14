//
//  SettingViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: ViewModelType {
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: SettingCoordinator?
    
    struct Input{


    }
    
    struct Output{
    }
    
    init(coordinator: SettingCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {

        return Output()
    }
}
