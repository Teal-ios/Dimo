//
//  TapmanCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit

final class TabmanCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tabman
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showCharacterDetailViewController()
    }
    
    func showCharacterDetailViewController() {
        let viewModel = CharacterDetailViewModel(coordinator: self)
        let vc = CharacterDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
        
    }
        
    func showFeedDetailViewController() {
        let viewModel = FeedDetailViewModel(coordinator: self)
        let vc = FeedDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
