//
//  LoginStartViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginStartViewModel: ViewModelType {
    
    var disposebag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        var dimoLoginButtonTapped: ControlEvent<Void>
        
//        var kakaoLoginButtonTapped: ControlEvent<Void>
//        var googleLoginButtonTapped: ControlEvent<Void>
//        var appleLoginButtonTapped: ControlEvent<Void>
// 추후 작업 예정
    }
    
    struct Output{
        var dimoLoginButtonTapped: ControlEvent<Void>
//        var kakaoLoginButtonTapped: ControlEvent<Void>
//        var googleLoginButtonTapped: ControlEvent<Void>
//        var appleLoginButtonTapped: ControlEvent<Void>
    }

    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.dimoLoginButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showDimoLoginViewController()
        }.disposed(by: disposebag)
        
        return Output(dimoLoginButtonTapped: input.dimoLoginButtonTapped)
    }
    
    func pushSignupTermsViewController() {
        self.coordinator?.showSignupTermsViewController()
    }
}
