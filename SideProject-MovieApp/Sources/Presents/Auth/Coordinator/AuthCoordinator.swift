//
//  InitialCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit

final class AuthCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .auth
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLoginSplshViewController()
    }
    
    func showLoginSplshViewController() {
        let viewModel = LoginSplashViewModel(coordinator: self)
        let vc = LoginSplashViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [vc]
    }
    
    func showLoginStartViewController() {
        let viewModel = LoginStartViewModel(coordinator: self)
        let vc = LoginStartViewController(viewModel: viewModel)
        changeAnimation()
        navigationController.viewControllers = [vc]
    }
    
    func showOnboardingViewController() {
        let viewModel = OnBoardingViewModel(coordinator: self)
        let vc = OnBoardingViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
        showSignupTermsViewController()

    }
    func showSignupTermsViewController() {
        let viewModel = SignupTermsViewModel(coordinator: self)
        let vc = SignupTermsViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showSignupIdentificationViewController() {
        let viewModel = SignupIdentificationViewModel(coordinator: self)
        let vc = SignupIdentificationViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showIDRegisterViewController() {
        let viewModel = IDNickNameViewModel(coordinator: self, currentViewCases: .IDRegister)
        let vc = IDRegisterViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showNickNameViewController() {
        let viewModel = IDNickNameViewModel(coordinator: self, currentViewCases: .NickName)
        let vc = NickNameViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showPasswordViewController() {
        let viewModel = PasswordViewModel(coordinator: self, currentViewCases: .Password)
        let vc = PasswordViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showDimoLoginViewController() {
        let viewModel = DimoLoginViewModel(coordinator: self)
        let vc = DimoLoginViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}


