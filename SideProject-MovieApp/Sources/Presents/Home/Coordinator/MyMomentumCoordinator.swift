//
//  MyMomentumCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit

final class MyMomentumCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showMyMomentumViewController()
    }
    
    func showMyMomentumViewController() {
        let viewModel = MyMomentumViewModel(coordinator: self)
        let vc = MyMomentumViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
}
