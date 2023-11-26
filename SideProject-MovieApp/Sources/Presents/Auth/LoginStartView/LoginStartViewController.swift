//
//  LoginStartViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

import UIKit
import RxCocoa
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn

class LoginStartViewController: BaseViewController {
    
    //MARK: Delegate
    let loginStartView = LoginStartView()
    
    //MARK: Delegate
    private var viewModel: LoginStartViewModel
    
    private lazy var input = LoginStartViewModel.Input(didTappedDimoLoginButton: self.loginStartView.dimoLoginButton.rx.tap,
                                                       didTappedKakaoLoginButton: self.loginStartView.kakaoLoginButton.rx.tap,
                                                       didTappedGoogleLoginButton: self.loginStartView.googleLoginButton.rx.tap,
                                                       didTappedAppleLoginButton: self.loginStartView.appleLoginButton.rx.tap,
                                                       didTappedSignupButton: self.loginStartView.signupButton.rx.tap)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("LoginStartViewController: fatal error")
    }
    
    init(viewModel: LoginStartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = loginStartView
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
        output.kakaoLoginButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.didTappedKakaoLoginButton()
            }
            .disposed(by: disposeBag)
        
        output.googleLoginButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.didTappedGoogleLoginButton()
            }
            .disposed(by: disposeBag)
        
        output.appleLoginButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                let request = ASAuthorizationAppleIDProvider().createRequest()
                request.requestedScopes = [.fullName, .email]
                
                let controller = ASAuthorizationController(authorizationRequests: [request])
                controller.delegate = self
                controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
                controller.performRequests()
            }
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Apple 로그인
extension LoginStartViewController: ASAuthorizationControllerDelegate {
    
    // 로그인 성공시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let snsType = SnsLoginType.apple.rawValue
            print("Apple UID: \(userIdentifier)")
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authString = String(data: authorizationCode, encoding: .utf8),
                let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
            }
            
            if let fullName = fullName {
                if let givenName = fullName.givenName {
                    guard let firstName = fullName.givenName else { return } // 이름
                    let lastName = givenName
                    let name = lastName + firstName
                    viewModel.didTrySocialLogin(with: .apple(name: name, id: userIdentifier, snsType: snsType))
                } else {
                    viewModel.didTrySocialLogin(with: .apple(name: "가나다라", id: userIdentifier, snsType: snsType))
                }
            }
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
        default:
            break
        }
    }
    
    // 로그인 실패시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "애플 로그인 실패", message: "애플 로그인에 실패했습니다.", preferredStyle: UIAlertController.Style.alert)
        let addAlertAction = UIAlertAction(title: "확인", style: .default) { _ in
            UserDefaultManager.isSocialLogin = nil
        }
        alert.addAction(addAlertAction)
        self.present(alert, animated: true, completion: nil)
        UserDefaultManager.isSocialLogin = nil
    }
}

// MARK: - Kakao 로그인
extension LoginStartViewController {
    
    private func presentKakaoOAuthFailedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "카카오 로그인 실패", message: "카카오 로그인에 실패했습니다.", preferredStyle: UIAlertController.Style.alert)
            let addAlertAction = UIAlertAction(title: "확인", style: .default) { _ in
                UserDefaultManager.isSocialLogin = nil
            }
            alert.addAction(addAlertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func didTappedKakaoLoginButton() {
       let kakaoTalkIsDownloaded = UserApi.isKakaoTalkLoginAvailable()
        
        if kakaoTalkIsDownloaded {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                    self?.presentKakaoOAuthFailedAlert()
                } else {
                    UserApi.shared.me() {(user, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            guard let userId = user?.id else { return }
                            guard let userName = user?.properties?["nickname"] else { return }
                            let snsType = SnsLoginType.kakao.rawValue
                            self?.viewModel.didTrySocialLogin(with: .kakao(name: userName, id: String(userId), snsType: snsType))
                            
                        }
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                    self?.presentKakaoOAuthFailedAlert()
                } else {
                    
                    UserApi.shared.me() {(user, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            guard let userId = user?.id else { return }
                            guard let userName = user?.properties?["nickname"] else { return }
                            let snsType = SnsLoginType.kakao.rawValue
                            self?.viewModel.didTrySocialLogin(with: .kakao(name: userName, id: String(userId), snsType: snsType))
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Google 로그인
extension LoginStartViewController {
    
    private func didTappedGoogleLoginButton() {
        let gidConfig = GIDConfiguration(clientID: APIKey.googleClientID)
        
        
        GIDSignIn.sharedInstance.signIn(with: gidConfig, presenting: self) { gidGoogleUser, error in
            guard error == nil else { return }
            guard let gidGoogleUser = gidGoogleUser else { return }
            self.showGoogleAuthorizationView(user: gidGoogleUser)
        }
    }
    
    func showGoogleAuthorizationView(user: GIDGoogleUser) {
        user.authentication.do { [weak self] authentication, error in
            guard error == nil else { return }
            guard let authentication = authentication,
                  let idToken = authentication.idToken else { return }
            guard let userId = user.userID else { return }
            guard let userName = user.profile?.name else { return }
            let snsType = SnsLoginType.google.rawValue
            self?.viewModel.didTrySocialLogin(with: .google(name: userName, id: userId, snsType: snsType))
        }
    }
}
