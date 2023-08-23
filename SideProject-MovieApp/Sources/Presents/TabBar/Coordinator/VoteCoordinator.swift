//
//  VoteCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit

final class VoteCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
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
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let voteRepositoryImpl = VoteRepositoyImpl(dataTransferService: dataTransferService)
        let voteUseCaseImpl = VoteUseCaseImpl(voteRepository: voteRepositoryImpl)
        let viewModel = VoteViewModel(coordinator: self, voteUseCase: voteUseCaseImpl)
        let vc = VoteViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
    
    func showSearchViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let voteRepositoryImpl = VoteRepositoyImpl(dataTransferService: dataTransferService)
        let voteUseCaseImpl = VoteUseCaseImpl(voteRepository: voteRepositoryImpl)
        let viewModel = SearchViewModel(coordinator: self, voteUseCase: voteUseCaseImpl)
        let vc = SearchViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showRecommendViewController(category: String) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let voteRepositoryImpl = VoteRepositoyImpl(dataTransferService: dataTransferService)
        let voteUseCaseImpl = VoteUseCaseImpl(voteRepository: voteRepositoryImpl)
        let viewModel = RecommendViewModel(coordinator: self, voteUseCase: voteUseCaseImpl, category: category)
        let vc = RecommendViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDigViewController(characterInfo: CharacterInfo) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let voteRepositoryImpl = VoteRepositoyImpl(dataTransferService: dataTransferService)
        let voteUseCaseImpl = VoteUseCaseImpl(voteRepository: voteRepositoryImpl)
        let viewModel = DigViewModel(coordinator: self, voteUseCase: voteUseCaseImpl, characterInfo: characterInfo)
        let vc = DigViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showVoteCompleteViewController(characterInfo: CharacterInfo) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let voteRepositoryImpl = VoteRepositoyImpl(dataTransferService: dataTransferService)
        let voteUseCaseImpl = VoteUseCaseImpl(voteRepository: voteRepositoryImpl)
        let viewModel = VoteCompleteViewModel(coordinator: self, voteUseCase: voteUseCaseImpl, characterInfo: characterInfo)
        let vc = VoteCompleteViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
