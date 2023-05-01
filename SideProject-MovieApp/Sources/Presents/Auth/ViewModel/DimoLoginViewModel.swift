//
//  DimoLoginViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/13.
//

import Foundation
import RxCocoa
import RxSwift

class DimoLoginViewModel: ViewModelType {
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        let nextButtonTapped: ControlEvent<Void>
        let idText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
    }
    
    struct Output{
        var nextButtonTapped: ControlEvent<Void>
        let loginValid: Observable<Bool>
    }
    
    init(coordinator: AuthCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.nextButtonTapped.bind { [weak self] _ in
//            self?.coordinator?.showPopupViewController()
            self?.coordinator?.connectHomeTabBarCoordinator()
        }.disposed(by: disposebag)
        
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$])[A-Za-z\\d!@#$]{8,16}$"
        
        let pwValid = input.passwordText
            .orEmpty
            .map {  NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: $0) }
            .share()
        
        let nicknameValid = input.idText.orEmpty.map { str in
            str.count > 3
        }
        
        let loginValid = Observable.combineLatest(nicknameValid, pwValid)
            .map { nickname, password in
                return nickname && password
            }
        
        
        return Output(nextButtonTapped: input.nextButtonTapped, loginValid: loginValid)
    }
}


