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
        let didTappedSearchButton: ControlEvent<Void>
    }
    
    private var isTappedSearchButton = BehaviorRelay<Bool>(value: false)
    
    struct Output {
        let isTappedSearchButton: BehaviorRelay<Bool>
    }
    
    init(coordinator: SettingCoordinator?, networkUsecase: SettingUseCase) {
        self.coordinator = coordinator
        self.networkUsecase = networkUsecase
    }
    
    func transform(input: Input) -> Output {
        input.didTappedSearchButton
            .withUnretained(self)
            .bind { (vm, _) in
                vm.isTappedSearchButton.accept(true)
            }
            .disposed(by: disposeBag)
        
        
        
        
        return Output(isTappedSearchButton: self.isTappedSearchButton)
    }
    
}
