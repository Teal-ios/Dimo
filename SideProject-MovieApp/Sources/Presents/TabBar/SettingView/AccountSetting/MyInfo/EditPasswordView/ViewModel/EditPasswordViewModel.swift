//
//  EditPasswordViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxCocoa
import RxSwift

class EditPasswordViewModel: ViewModelType {
    var disposeBag: DisposeBag = DisposeBag()
    
    private weak var coordinator: SettingCoordinator?
    
    struct Input {
        let passwordText: ControlProperty<String?>
        let checkpwText: ControlProperty<String?>
        let didNextButtonTap: Signal<String>
    }
    
    struct Output {
        let pwConditionValidation: Observable<Bool>
        //Password 조건에 만족하는지 판별
        let passwordDuplicationValid: Observable<Bool>
    }
    
    
    init(coordinator: SettingCoordinator? = nil) {
        self.coordinator = coordinator
    }
    func transform(input: Input) -> Output {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$])[A-Za-z\\d!@#$]{8,16}$"
        
        let pwValid = input.passwordText
            .orEmpty
            .map {  NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: $0) }
            .share()
        
        
        input.didNextButtonTap
            .emit { [weak self] text in
                guard let self = self else { return }
                print(text)
            }
            .disposed(by: disposeBag)
        
        let passwordDuplicationValid = Observable.combineLatest(input.passwordText.orEmpty, input.checkpwText.orEmpty).map { $0 == $1 && $0.count >= 8 && $0.count <= 16 }
        
        return Output(pwConditionValidation: pwValid, passwordDuplicationValid: passwordDuplicationValid)
    }
}
