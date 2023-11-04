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
    
    enum SocialLoginType {
        case kakao(name: String, id: String, snsType: String)
        case google
        case apple
    }
    
    var disposeBag = DisposeBag()
    private var authUseCase: AuthUseCase
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        var didTappedDimoLoginButton: ControlEvent<Void>
        var didTappedKakaoLoginButton: ControlEvent<Void>
        var didTappedGoogleLoginButton: ControlEvent<Void>
//        var appleLoginButtonTapped: ControlEvent<Void>
        var didTappedSignupButton: ControlEvent<Void>
// 추후 작업 예정
    }
    
    struct Output{
        var dimoLoginButtonTapped: ControlEvent<Void>
        var kakaoLoginButtonTapped: ControlEvent<Void>
        var googleLoginButtonTapped: ControlEvent<Void>
//        var appleLoginButtonTapped: ControlEvent<Void>
    }

    init(coordinator: AuthCoordinator?, authUseCase: AuthUseCase) {
        self.coordinator = coordinator
        self.authUseCase = authUseCase
    }
    
    func transform(input: Input) -> Output {
        input.didTappedDimoLoginButton.bind { [weak self] _ in
            guard let self else { return }
            UserDefaultManager.snsType = "none"
            self.coordinator?.showDimoLoginViewController()
        }.disposed(by: disposeBag)
        
        input.didTappedSignupButton.bind { [weak self] _ in
            guard let self else { return }
            UserDefaultManager.snsType = "none"
            self.coordinator?.showJoinTermsViewController()
        }
        .disposed(by: disposeBag)
        
        input.didTappedKakaoLoginButton.bind { [weak self] _ in
            guard let self else { return }
            UserDefaultManager.snsType = "kakao"
//            self.coordinator?.showErrorCommonViewController()
        }
        .disposed(by: disposeBag)
        
        input.didTappedGoogleLoginButton.bind { [weak self] _ in
            guard let self else { return }
            UserDefaultManager.snsType = "google"
//            self.coordinator?.showErrorNotFoundViewController()
        }
        .disposed(by: disposeBag)
        
        return Output(dimoLoginButtonTapped: input.didTappedDimoLoginButton, kakaoLoginButtonTapped: input.didTappedKakaoLoginButton, googleLoginButtonTapped: input.didTappedGoogleLoginButton)
    }
}

extension LoginStartViewModel {
    
    func didTrySocialLogin(with snsType: SocialLoginType) {
        switch snsType {
        case .kakao(let name, let id, let snsType):
            let kakaoLoginQuery = KakaoLoginQuery(userId: id, name: name, snsType: snsType)
            Task {
                let kakaoLogin = try await authUseCase.executeKakaoLogin(query: kakaoLoginQuery)
                print("KAKO LOGIN: ", kakaoLogin)
                if kakaoLogin.code == 200 {
                    await MainActor.run {
                        self.coordinator?.showTermsOfUseViewController()
                    }
                }
            }
        case .google:
            print("GOOGLE LOGIN")
        case .apple:
            print("APPLE LOGIN")
        }
    }
}
