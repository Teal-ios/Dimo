//
//  InitialCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit

final class AuthCoordinator: Coordinator {
    
    enum SignUpFlow {
        case dimo
        case sns
    }
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
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
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let authRepositoryImpl = AuthRepositoryImpl(dataTransferService: dataTransferService)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = LoginStartViewModel(coordinator: self, authUseCase: authUseCaseImpl)
        let vc = LoginStartViewController(viewModel: viewModel)
        changeAnimation()
        navigationController.viewControllers = [vc]
    }
    
    func showOnboardingViewController() {
        let viewModel = OnBoardingViewModel(coordinator: self)
        let vc = OnBoardingViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
        showTermsOfUseViewController(with: .dimo)
    }
    
    func showTermsOfUseViewController(with flow: SignUpFlow) {
        let viewModel = TermsOfUseViewModel(coordinator: self, signUpFlow: flow)
        let vc = TermsOfUseViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSignupIdentificationViewController(with flow: SignUpFlow) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let authRepositoryImpl = AuthRepositoryImpl(dataTransferService: dataTransferService)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = SignupIdentificationViewModel(coordinator: self,
                                                      authUseCase: authUseCaseImpl,
                                                      signUpFlow: flow)
        let vc = SignupIdentificationViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showIDRegisterViewController(with flow: SignUpFlow) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let authRepositoryImpl = AuthRepositoryImpl(dataTransferService: dataTransferService)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = IDNickNameViewModel(coordinator: self,
                                            authUseCase: authUseCaseImpl,
                                            signUpFlow: flow)
        let vc = IDRegisterViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showNickNameViewController(with flow: SignUpFlow) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = NicknameViewModel(coordinator: self,
                                          settingUseCase: settingUseCaseImpl,
                                          signUpFlow: flow)
        let vc = NickNameViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showPasswordViewController(with flow: SignUpFlow) {
        let viewModel = PasswordViewModel(coordinator: self, signUpFlow: flow)
        let vc = PasswordViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDimoLoginViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let authRepositoryImpl = AuthRepositoryImpl(dataTransferService: dataTransferService)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = DimoLoginViewModel(coordinator: self, authUseCase: authUseCaseImpl)
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
    
    func showJoinMbtiViewController(with flow: SignUpFlow) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let authRepositoryImpl = AuthRepositoryImpl(dataTransferService: dataTransferService)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = JoinMbtiViewModel(coordinator: self,
                                          authUseCase: authUseCaseImpl,
                                          signUpFlow: flow)
        let vc = JoinMbtiViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func connectHomeTabBarCoordinator() {
        let tabBarCoordinator = HomeTabBarCoordinator(self.navigationController)
        tabBarCoordinator.parentCoordinator = self
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
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let authRepositoryImpl = AuthRepositoryImpl(dataTransferService: dataTransferService)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = FindIDViewModel(coordinator: self, authUseCase: authUseCaseImpl)
        let vc = FindIDViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showNotificationIDViewController() {
        let viewModel = NotificationIDViewModel(coordinator: self)
        let vc = NotificationIDViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFindPWViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let authRepositoryImpl = AuthRepositoryImpl(dataTransferService: dataTransferService)
        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
        let viewModel = FindPWViewModel(authUseCase: authUseCaseImpl, coordinator: self)
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
