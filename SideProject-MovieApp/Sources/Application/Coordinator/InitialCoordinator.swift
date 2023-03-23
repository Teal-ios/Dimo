//
//  InitialCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit

final class InitialCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        let vc = InitialViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        print(childCoordinators)
    }
}
