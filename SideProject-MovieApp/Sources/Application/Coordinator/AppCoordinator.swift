//
//  AppCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit

final class AppCoordinator: Coordinator {

    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .app

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        /// 조건에 따른 분기처리 필요
//        connectTabBarFlow()
        connectAuthFlow()
//        connectSettingFlow()
    }

    private func connectAuthFlow() {
        let authCoordinator = AuthCoordinator(self.navigationController)
        authCoordinator.delegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
    
    private func connectTabBarFlow() {
        let homeTabBarCoordinator = HomeTabBarCoordinator(self.navigationController)
        homeTabBarCoordinator.delegate = self
        homeTabBarCoordinator.start()
        childCoordinators.append(homeTabBarCoordinator)
    }
    
    private func connectSettingFlow() {
        let settingCoordinator = SettingCoordinator(self.navigationController)
        settingCoordinator.delegate = self
        settingCoordinator.start()
        childCoordinators.append(settingCoordinator)
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
