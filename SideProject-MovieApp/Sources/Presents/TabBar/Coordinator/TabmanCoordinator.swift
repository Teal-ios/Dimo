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
        let tabmanViewModel = CharacterDetailViewModel(coordinator: self)
        let tabmanviewController = CharacterDetailViewController(viewModel: tabmanViewModel)
        tabmanviewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(tabmanviewController, animated: true)
    }
    
    
    func showFeedDetailViewController() {
        let viewModel = FeedDetailViewModel(coordinator: self)
        let vc = FeedDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFeedDetailMoreMyViewMController() {
        let viewModel = FeedDetailMoreMyViewModel(coordinator: self)
        let vc = FeedDetailMoreMyViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func showWriteViewController() {
        let viewModel = WriteViewModel(coordinator: self)
        let vc = WriteViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showFeedDetailDeleteViewController() {
        let viewModel = FeedDetailDeleteViewModel(coordinator: self)
        let vc = FeedDetailDeleteViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
}
