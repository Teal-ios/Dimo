//
//  HomeCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit

final class HomeCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showHomeViewController()
    }
    
    func showHomeViewController() {
        let viewModel = HomeViewModel(coordinator: self)
        let vc = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
}
