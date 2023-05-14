//
//  SettingCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit

final class SettingCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showSettingViewController()
    }
    
    func showSettingViewController() {
        let viewModel = SettingViewModel(coordinator: self)
        let vc = SettingViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
}
