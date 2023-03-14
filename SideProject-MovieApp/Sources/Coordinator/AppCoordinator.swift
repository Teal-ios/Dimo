//
//  AppCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    let window: UIWindow
    
    init(window: UIWindow) {
        self.childCoordinators = []
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        let initialCoordinator = InitialCoordinator(window: window)
        print("start")
        initialCoordinator.start()
        window.rootViewController = initialCoordinator.navigationController
        childCoordinators.append(initialCoordinator)
        window.makeKeyAndVisible()
        print(childCoordinators)
    }
}
