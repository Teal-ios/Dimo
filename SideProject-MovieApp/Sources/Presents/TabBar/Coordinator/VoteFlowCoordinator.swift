//
//  VoteFlowCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import UIKit
import RxCocoa

final class VoteFlowCoordinator: Coordinator, CoordinatorDelegate {
    
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    var characterInfo: CharacterInfo
    var isVote: Bool
    var voteFlowCancelButtonTap = PublishRelay<Void>()
    
    init(_ navigationController: UINavigationController, characterInfo: CharacterInfo, isVote: Bool) {
        self.navigationController = navigationController
        self.characterInfo = characterInfo
        self.isVote = isVote
    }
    
    func start() {
        switch isVote {
        case true:
            showVoteCompleteViewController(characterInfo: characterInfo)
        case false:
            showDigViewController(characterInfo: characterInfo)
        }
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
    
    func showTabmanCoordinator(character: Characters) {
        let tabmanCoordinator = TabmanCoordinator(navigationController, character: character, connectconnetTabmanCoordinatorViewController: .tabman, review: nil)
        tabmanCoordinator.delegate = self
        self.childCoordinators.append(tabmanCoordinator)
        tabmanCoordinator.start()
    }
    
    func showVoteCoordinator() {
        let voteCoordinator = VoteCoordinator(navigationController)
        voteCoordinator.parentCoordinator = self
        voteCoordinator.delegate = self

        voteCoordinator.start()
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func showVoteAnotherCharacterViewController(characters: [Result?]) {
        let viewModel = VoteAnotherCharacterViewModel(coordinator: self, characters: characters)
        let viewController = VoteAnotherCharacterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

