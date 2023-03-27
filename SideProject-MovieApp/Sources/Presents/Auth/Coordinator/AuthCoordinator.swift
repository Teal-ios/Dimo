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
        showOnboardingViewController()
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
}


