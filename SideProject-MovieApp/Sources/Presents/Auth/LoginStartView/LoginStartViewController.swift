//
//  LoginStartViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

import UIKit
import RxCocoa
import AuthenticationServices


class LoginStartViewController: BaseViewController {
    
    //MARK: Delegate
    let loginStartView = LoginStartView()
    
    //MARK: Delegate
    private var viewModel: LoginStartViewModel
    
    private lazy var input = LoginStartViewModel.Input(dimoLoginButtonTapped: self.loginStartView.dimoLoginButton.rx.tap, signupButtonTapped: self.loginStartView.signupButton.rx.tap)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("LoginStartViewController: fatal error")
    }
    
    init(viewModel: LoginStartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func loadView() {
        view = loginStartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
        self.loginStartView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
    }
}

extension LoginStartViewController: ASAuthorizationControllerDelegate {
    @objc
    func appleLoginButtonTapped() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
    // 로그인 성공시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authString = String(data: authorizationCode, encoding: .utf8),
                let tokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
            }
            
            print("useridentifier: \(userIdentifier)")
            print("fullName: \(fullName)")
            print("email: \(email)")
            
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "00000.abcabcabcabc.0000") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("authorized")
            // The Apple ID credential is valid.
            case .revoked:
                print("revoked")
            case .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("notFound")
                DispatchQueue.main.async {
                    // self.window?.rootViewController?.showLoginViewController()
                }
            default:
                break
            }
        }
        return true
    }
    
    // 로그인 실패시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("--login err")
    }
}


