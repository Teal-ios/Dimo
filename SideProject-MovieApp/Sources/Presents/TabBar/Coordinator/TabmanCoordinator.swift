//
//  TapmanCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import RxCocoa

final class TabmanCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tabman
    var character: Characters
    var characterId = PublishRelay<Int>()
    
    init(_ navigationController: UINavigationController, character: Characters) {
        self.navigationController = navigationController
        self.character = character
    }
    
    func start() {
        let tabmanViewModel = CharacterDetailViewModel(coordinator: self, character: character)
        let tabmanviewController = CharacterDetailViewController(viewModel: tabmanViewModel)
        tabmanviewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(tabmanviewController, animated: true)
    }
    
    
    func showFeedDetailViewController(review: ReviewList) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = FeedDetailViewModel(coordinator: self, characterDetailUseCase: characterUseCaseImpl, review: review)
        let vc = FeedDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFeedDetailMoreMyViewMController() {
        let viewModel = FeedDetailMoreMyViewModel(coordinator: self)
        let vc = FeedDetailMoreMyViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showFeedDetailMoreAnotherViewMController() {
        let viewModel = FeedDetailMoreAnotherViewModel(coordinator: self)
        let vc = FeedDetailMoreAnotherViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func showWriteViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = WriteViewModel(coordinator: self, characterDetailUseCase: characterUseCaseImpl, characterId: character.character_id)
        viewModel.delegate = self
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
    
    func showFeedDetailHideReviewAlertViewController() {
        let viewModel = FeedDetailHideReviewAlertViewModel(coordinator: self)
        let vc = FeedDetailHideReviewAlertViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showFeedDetailHideUserAlertViewController() {
        let viewModel = FeedDetailHideUserAlertViewModel(coordinator: self)
        let vc = FeedDetailHideUserAlertViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
}

extension TabmanCoordinator: sendPostReviewDelegate {
    func sendPostReview(character_id: Int) {
        self.characterId.accept(character_id)
    }
}
