//
//  AppCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .app
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /**
     isSocialLogin == nil -> AuthFlow
     isSocialLogin == true or false(디모 로그인) -> TabBarFlow
     **/
    func start() {
        if let isLogined = UserDefaultManager.isSocialLogin {
            if isLogined {
                connectTabBarFlow()
            }
        } else {
            connectAuthFlow()
        }
    }

    private func connectAuthFlow() {
        let authCoordinator = AuthCoordinator(self.navigationController)
        authCoordinator.parentCoordinator = self
        authCoordinator.delegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
    
    private func connectTabBarFlow() {
        let homeTabBarCoordinator = HomeTabBarCoordinator(self.navigationController)
        homeTabBarCoordinator.parentCoordinator = self
        homeTabBarCoordinator.delegate = self
        homeTabBarCoordinator.start()
        childCoordinators.append(homeTabBarCoordinator)
    }
}

extension AppCoordinator: CoordinatorDelegate {

    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })

        self.navigationController.viewControllers.removeAll()

        switch childCoordinator.type {
        case .auth:
            self.connectAuthFlow()
        default:
            break
        }
    }
}
