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
        case google(name: String, id: String, snsType: String)
        case apple(name: String, id: String, snsType: String)
    }
    
    var disposeBag = DisposeBag()
    private var authUseCase: AuthUseCase
    private weak var coordinator: AuthCoordinator?
    
    struct Input {
        var didTappedDimoLoginButton: ControlEvent<Void>
        var didTappedKakaoLoginButton: ControlEvent<Void>
        var didTappedGoogleLoginButton: ControlEvent<Void>
        var didTappedAppleLoginButton: ControlEvent<Void>
        var didTappedSignupButton: ControlEvent<Void>
    }
    
    struct Output {
        var dimoLoginButtonTapped: ControlEvent<Void>
        var kakaoLoginButtonTapped: ControlEvent<Void>
        var googleLoginButtonTapped: ControlEvent<Void>
        var appleLoginButtonTapped: ControlEvent<Void>
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
//            self.coordinator?.showErrorCommonViewController()
        }
        .disposed(by: disposeBag)
        
        input.didTappedGoogleLoginButton.bind { [weak self] _ in
            guard let self else { return }
//            self.coordinator?.showErrorNotFoundViewController()
        }
        .disposed(by: disposeBag)
        
        return Output(dimoLoginButtonTapped: input.didTappedDimoLoginButton,
                      kakaoLoginButtonTapped: input.didTappedKakaoLoginButton,
                      googleLoginButtonTapped: input.didTappedGoogleLoginButton,
                      appleLoginButtonTapped: input.didTappedAppleLoginButton)
    }
}

extension LoginStartViewModel {
    
    func didTrySocialLogin(with snsType: SocialLoginType) {
        switch snsType {
        case .kakao(let name, let id, let snsType):
            let kakaoLoginQuery = KakaoLoginQuery(userId: id, name: name, snsType: snsType)
            Task {
                let kakaoLogin = try await authUseCase.executeKakaoLogin(query: kakaoLoginQuery)
                
                if kakaoLogin.code == 200 {
                    let socialLoginCheckQuery = SocialLoginCheckQuery(userId: id, snsType: "kakao")
                    let socialLoginCheck = await checkIsRegisteredAccount(query: socialLoginCheckQuery)
                    if socialLoginCheck?.code == 200 {
                        await MainActor.run {
                            self.coordinator?.connectHomeTabBarCoordinator()
                        }
                    } else if socialLoginCheck?.code == 201 { // 가입된 사용자가 아닌 경우
                        await MainActor.run {
                            self.saveUserInformation(userId: id, userName: name, snsType: snsType)
                            self.coordinator?.showTermsOfUseViewController(isSnsLogin: true)
                        }
                    } else {
                        print("카카오 로그인 실패")
                    }
                }
            }
        case .google(let name, let id, let snsType):
            let googleLoginQuery = GoogleLoginQuery(user_id: id, name: name, sns_type: snsType)
            
            Task {
                let googleLogin = try await authUseCase.executeGoogleLogin(query: googleLoginQuery)
                if googleLogin.code == 200 {
                    let socialLoginCheckQuery = SocialLoginCheckQuery(userId: id, snsType: "google")
                    let socialLoginCheck = await checkIsRegisteredAccount(query: socialLoginCheckQuery)
                    if socialLoginCheck?.code == 200 {
                        await MainActor.run {
                            self.coordinator?.connectHomeTabBarCoordinator()
                        }
                    } else if socialLoginCheck?.code == 201 { // 가입된 사용자가 아닌 경우
                        await MainActor.run {
                            self.saveUserInformation(userId: id, userName: name, snsType: snsType)
                            self.coordinator?.showTermsOfUseViewController(isSnsLogin: true)
                        }
                    } else {
                        print("구글 로그인 실패")
                    }
                }
            }
        case .apple:
            print("APPLE LOGIN")
        }
    }
    
    private func checkIsRegisteredAccount(query: SocialLoginCheckQuery) async -> SocialLoginCheck? {
        do {
            return try await authUseCase.executeSocialLoginCheck(query: query)
        } catch let error {
            print("ERROR: \(error)")
            return nil
        }
    }
}

// MARK: UserDefaultManager
extension LoginStartViewModel {
    
    private func saveUserInformation(userId: String, userName: String, snsType: String) {
        UserDefaultManager.userId = userId
        UserDefaultManager.userName = userName
        UserDefaultManager.snsType = snsType
    }
}
