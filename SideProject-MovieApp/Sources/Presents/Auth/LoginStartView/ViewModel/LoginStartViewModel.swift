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
    
    var disposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        var dimoLoginButtonTapped: ControlEvent<Void>
        
        var kakaoLoginButtonTapped: ControlEvent<Void>
        var googleLoginButtonTapped: ControlEvent<Void>
//        var appleLoginButtonTapped: ControlEvent<Void>
        var signupButtonTapped: ControlEvent<Void>
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
        }.disposed(by: disposeBag)
        
        input.signupButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showJoinTermsViewController()
        }
        .disposed(by: disposeBag)
        
        input.kakaoLoginButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showErrorCommonViewController()
        }
        .disposed(by: disposeBag)
        
        input.googleLoginButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showErrorNotFoundViewController()
        }
        .disposed(by: disposeBag)
        
        return Output(dimoLoginButtonTapped: input.dimoLoginButtonTapped)
    }
}
