//
//  LoginCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

//import UIKit
//
//final class LoginCoordinator: Coordinator {
//    weak var delegate: CoordinatorDelegate?
//    var childCoordinators = [Coordinator]()
//    var navigationController: UINavigationController
//    var type: CoordinatorStyleCase = .login
//    
//    private let userDefaults = UserDefaults.standard
//
//    init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        showLoginSplshViewController()
//    }
//    
//    func showLoginSplshViewController() {
//        let viewModel = LoginSplashViewModel(coordinator: self)
//        let vc = LoginSplashViewController(viewModel: viewModel)
//        navigationController.viewControllers = [vc]
//    }
//    
//    func showLoginStartViewController() {
//        let viewModel = LoginStartViewModel(coordinator: self)
//        let vc = LoginStartViewController(viewModel: viewModel)
//        navigationController.viewControllers = [vc]
//    }
//}
//
//
