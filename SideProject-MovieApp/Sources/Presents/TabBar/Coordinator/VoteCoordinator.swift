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
    
    func showSearchViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let contentRepositoryImpl = ContentRepositoryImpl(dataTransferService: dataTransferService)
        let contentUseCaseImpl = ContentUseCaseImpl(contentRepository: contentRepositoryImpl)
        let viewModel = SearchViewModel(coordinator: self, contentUseCase: contentUseCaseImpl)
        let vc = SearchViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
