//
//  EditNotificationViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/04.
//

import Foundation
import RxSwift
import RxCocoa

final class PushNotificationSettingViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    weak var coordinator: SettingCoordinator?
    let networkUsecase: SettingUseCase
    
    
    struct Input {
        let didTappedAllNotificationSwitch: ControlProperty<Bool>
        let didTappedReplyNotificationSwitch: ControlProperty<Bool>
        let didTappedKeywordNotificationSwitch: ControlProperty<Bool>
        let didTappedDimoNewsNotificationSwitch: ControlProperty<Bool>
    }
    
    private var isTappedAllNotificationSwitch = PublishRelay<Bool>()
    private var isTappedReplyNotificationSwitch = PublishRelay<Bool>()
    private var isTappedKeywordNotificationSwitch = PublishRelay<Bool>()
    private var isTappedDimoNewsNotificationSwitch = PublishRelay<Bool>()
    
    struct Output {
        let isTappedAllNotificationSwitch: PublishRelay<Bool>
        let isTappedReplyNotificationSwitch: PublishRelay<Bool>
        let isTappedKeywordNotificationSwitch: PublishRelay<Bool>
        let isTappedDimoNewsNotificationSwitch: PublishRelay<Bool>
    }
    
    init(coordinator: SettingCoordinator?, networkUsecase: SettingUseCase) {
        self.coordinator = coordinator
        self.networkUsecase = networkUsecase
    }
    
    func transform(input: Input) -> Output {
        
        input.didTappedAllNotificationSwitch
            .withUnretained(self)
            .bind { (vm, isOn) in
                vm.isTappedAllNotificationSwitch.accept(isOn)
                vm.isTappedReplyNotificationSwitch.accept(isOn)
                vm.isTappedKeywordNotificationSwitch.accept(isOn)
                vm.isTappedDimoNewsNotificationSwitch.accept(isOn)
            }
            .disposed(by: disposeBag)
        
        input.didTappedReplyNotificationSwitch
            .withUnretained(self)
            .bind { (vm, isOn) in
                vm.isTappedReplyNotificationSwitch.accept(isOn)
            }
            .disposed(by: disposeBag)
        
        input.didTappedKeywordNotificationSwitch
            .withUnretained(self)
            .bind { (vm, isOn) in
                vm.isTappedKeywordNotificationSwitch.accept(isOn)
            }
            .disposed(by: disposeBag)
        
        input.didTappedDimoNewsNotificationSwitch
            .withUnretained(self)
            .bind { (vm, isOn) in
                vm.isTappedDimoNewsNotificationSwitch.accept(isOn)
            }
            .disposed(by: disposeBag)

        return Output(isTappedAllNotificationSwitch: self.isTappedAllNotificationSwitch,
                      isTappedReplyNotificationSwitch: self.isTappedReplyNotificationSwitch,
                      isTappedKeywordNotificationSwitch: self.isTappedKeywordNotificationSwitch,
                      isTappedDimoNewsNotificationSwitch: self.isTappedDimoNewsNotificationSwitch)
    }
}
