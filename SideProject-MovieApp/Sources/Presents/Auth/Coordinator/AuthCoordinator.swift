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
        let session = RxServiceImpl.shared
        let authRepositoryImpl = AuthRepositoryImpl(session: session)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = SignupIdentificationViewModel(coordinator: self, authUseCase: authUseCaseImpl)
        let vc = SignupIdentificationViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showIDRegisterViewController() {
        let session = RxServiceImpl.shared
        let authRepositoryImpl = AuthRepositoryImpl(session: session)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = IDNickNameViewModel(coordinator: self, authUseCase: authUseCaseImpl)
        let vc = IDRegisterViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showNickNameViewController() {
        let session = RxServiceImpl.shared
        let settingRepositoryImpl = SettingRepositoryImpl(session: session)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = NickNameViewModel(coordinator: self, settingUseCase: settingUseCaseImpl)
        let vc = NickNameViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showPasswordViewController() {
        let viewModel = PasswordViewModel(coordinator: self)
        let vc = PasswordViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showDimoLoginViewController() {
        let viewModel = DimoLoginViewModel(coordinator: self)
        let vc = DimoLoginViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showPopupViewController() {
        let viewModel = PopupViewModel(coordinator: self)
        let vc = PopupViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    func popPopupViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func showJoinMbtiViewController() {
        let viewModel = JoinMbtiViewModel(coordinator: self)
        let vc = JoinMbtiViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func connectHomeTabBarCoordinator() {
        let tabBarCoordinator = HomeTabBarCoordinator(self.navigationController)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
    
    func showJoinCompleteViewController() {
        let viewModel = JoinCompleteViewModel(coordinator: self)
        let vc = JoinCompleteViewController(viewModel: viewModel)
        changeAnimation()
        navigationController.viewControllers = [vc]
    }
    
    func showFindIDViewController() {
        let viewModel = FindIDViewModel(coordinator: self)
        let vc = FindIDViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showNotificationIDViewController() {
        let viewModel = NotificationIDViewModel(coordinator: self)
        let vc = NotificationIDViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFindPWViewController() {
        let viewModel = FindPWViewModel(coordinator: self)
        let vc = FindPWViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSendMessageViewController() {
        let viewModel = SendMessageViewModel(coordinator: self)
        let vc = SendMessageViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showErrorCommonViewController() {
        let viewModel = ErrorCommonViewModel(coordinator: self)
        let vc = ErrorCommonViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showErrorNotFoundViewController() {
        let viewModel = ErrorNotFoundViewModel(coordinator: self)
        let vc = ErrorNotFoundViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}



