//
//  MainCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/23.
//

import UIKit

final class MainCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .main
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showMainViewController()
    }
    
    func showMainViewController() {
        let viewModel = IamTheMainCharacterViewModel(coordinator: self)
        let vc = IamTheMainCharacterViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }

}
