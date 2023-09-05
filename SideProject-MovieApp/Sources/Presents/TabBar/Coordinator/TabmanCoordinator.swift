//
//  TapmanCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import RxCocoa

enum ConnetTabmanCoordinatorViewControllerCase {
    case feed
    case tabman
}

final class TabmanCoordinator: Coordinator, CoordinatorDelegate {
    
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tabman
    var character: Characters
    var characterId = PublishRelay<Int>()
    var modifyText = PublishRelay<String>()
    var deleteReview = PublishRelay<Void>()
    var currentCase: ConnetTabmanCoordinatorViewControllerCase = .tabman
    var review: ReviewList?

    init(_ navigationController: UINavigationController, character: Characters, connectconnetTabmanCoordinatorViewController: ConnetTabmanCoordinatorViewControllerCase, review: ReviewList?) {
        self.navigationController = navigationController
        self.character = character
        self.currentCase = connectconnetTabmanCoordinatorViewController
        self.review = review
    }
    
    func start() {
        switch currentCase {
        case .feed:
            guard let review = review else { return }
            showFeedDetailViewController(review: review)
        case .tabman:
            let tabmanViewModel = CharacterDetailViewModel(coordinator: self, character: character)
            let tabmanviewController = CharacterDetailViewController(viewModel: tabmanViewModel)
            tabmanviewController.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(tabmanviewController, animated: true)
        }
    }
    
    
    func showFeedDetailViewController(review: ReviewList) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = FeedDetailViewModel(coordinator: self, characterDetailUseCase: characterUseCaseImpl, review: review, modifyText: self.modifyText, deleteReviewEvent: self.deleteReview)
        let vc = FeedDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFeedDetailMoreMyViewController(review: ReviewList) {
        let viewModel = FeedDetailMoreMyViewModel(coordinator: self, review: review)
        let vc = FeedDetailMoreMyViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showFeedDetailMoreAnotherViewMController(user_id: String, review_id: Int) {
        let viewModel = FeedDetailMoreAnotherViewModel(coordinator: self, user_id: user_id, review_id: review_id)
        let vc = FeedDetailMoreAnotherViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
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
    
    func showModifyWriteViewController(review: ReviewList) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = ModifyWriteViewModel(coordinator: self, characterDetailUseCase: characterUseCaseImpl, review: review)
        viewModel.delegate = self
        let vc = ModifyWriteViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showFeedDetailDeleteViewController(review: ReviewList) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = FeedDetailDeleteViewModel(coordinator: self, characterDetailUseCase: characterUseCaseImpl, review: review)
        viewModel.delegate = self
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
    
    func showVoteFlowCoordinator(characterInfo: CharacterInfo, isVote: Bool) {
        let voteFlowCoordinator = VoteFlowCoordinator(navigationController, characterInfo: characterInfo, isVote: isVote)
        voteFlowCoordinator.delegate = self
        self.childCoordinators.append(voteFlowCoordinator)
        voteFlowCoordinator.start()
    }
    
    func showReportViewController(user_id: String, review_id: Int) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterUseCaseImpl = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = ReportViewModel(coordinator: self, characterDetailUseCase: characterUseCaseImpl, user_id: user_id, review_id: review_id)
        let vc = ReportViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension TabmanCoordinator: sendPostReviewDelegate {
    func sendPostReview(character_id: Int) {
        print("🍊")
        self.characterId.accept(character_id)
    }
}

extension TabmanCoordinator: sendModifyReviewDelegate {
    func sendModifyReview(text: String) {
        print("🍊")
        self.modifyText.accept(text)
    }
}

extension TabmanCoordinator: sendDeleteReviewDelegate {
    func sendDeleteReview() {
        self.deleteReview.accept(())
    }
}
