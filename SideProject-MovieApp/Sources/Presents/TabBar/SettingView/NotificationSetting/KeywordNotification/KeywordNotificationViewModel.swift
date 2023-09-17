//
//  KeywordNotificationViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/03.
//

import Foundation
import RxSwift
import RxCocoa

final class KeywordNotificationViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    var coordinator: SettingCoordinator?
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(coordinator: SettingCoordinator?) {
        self.coordinator = coordinator
    }
    
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
