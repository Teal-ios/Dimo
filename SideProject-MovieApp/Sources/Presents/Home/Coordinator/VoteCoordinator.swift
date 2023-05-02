//
//  VoteCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit

final class VoteCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showVoteViewController()
    }
    
    func showVoteViewController() {
        let viewModel = VoteViewModel(coordinator: self)
        let vc = VoteViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
}
