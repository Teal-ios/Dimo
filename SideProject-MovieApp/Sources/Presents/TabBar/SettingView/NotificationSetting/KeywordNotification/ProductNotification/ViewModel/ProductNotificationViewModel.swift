//
//  KeywordNotificationViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/02.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductNotificationViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    weak var coordinator: SettingCoordinator?
    let networkUsecase: SettingUseCase
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(coordinator: SettingCoordinator?, networkUsecase: SettingUseCase) {
        self.coordinator = coordinator
        self.networkUsecase = networkUsecase
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
    
}
