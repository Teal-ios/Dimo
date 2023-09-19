//
//  MyMomentumCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit

enum FeedCase {
    case my
    case other
}

final class MyMomentumCoordinator: Coordinator, CoordinatorDelegate {
    
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    var feedCase: FeedCase
    var other_id: String?
    
    init(_ navigationController: UINavigationController, feedCase: FeedCase, other_id: String? = nil) {
        self.navigationController = navigationController
        self.feedCase = feedCase
        self.other_id = other_id
    }

    func start() {
        switch feedCase {
        case .my:
            showMyMomentumViewController()
        case .other:
            guard let other_id = other_id else { return }
            showOtherMomentumViewController(other_id: other_id)
        }
    }
    
    func showMyMomentumViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let myMomentumRepositoryImpl = MyMomentumRepositoryImpl(dataTransferService: dataTransferService)
        let myMomentumUseCaseImpl = MyMomentumUseCaseImpl(myMomentumRepository: myMomentumRepositoryImpl)
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterDetailUseCase = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = MyMomentumViewModel(coordinator: self, myMomentumUseCase: myMomentumUseCaseImpl, characterDetailUseCase: characterDetailUseCase)
        let vc = MyMomentumViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
    
    func showOtherMomentumViewController(other_id: String) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let myMomentumRepositoryImpl = MyMomentumRepositoryImpl(dataTransferService: dataTransferService)
        let myMomentumUseCaseImpl = MyMomentumUseCaseImpl(myMomentumRepository: myMomentumRepositoryImpl)
        let characterDetailRepositoryImpl = CharacterDetailRepositoryImpl(dataTransferService: dataTransferService)
        let characterDetailUseCase = CharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepositoryImpl)
        let viewModel = OtherMomentumViewModel(coordinator: self, myMomentumUseCase: myMomentumUseCaseImpl, characterDetailUseCase: characterDetailUseCase, other_id: other_id)
        let vc = OtherMomentumViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showEditProfileViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let myMomentumRepositoryImpl = MyMomentumRepositoryImpl(dataTransferService: dataTransferService)
        let myMomentumUseCaseImpl = MyMomentumUseCaseImpl(myMomentumRepository: myMomentumRepositoryImpl)
        let viewModel = EditProfileViewModel(coordinator: self, myMomentumUseCase: myMomentumUseCaseImpl)
        let vc = EditProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMyContentMoreViewController(likeContentList: [LikeContent?]) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let myMomentumRepositoryImpl = MyMomentumRepositoryImpl(dataTransferService: dataTransferService)
        let myMomentumUseCaseImpl = MyMomentumUseCaseImpl(myMomentumRepository: myMomentumRepositoryImpl)
        let viewModel = MyContentMoreViewModel(coordinator: self, myMomentumUseCase: myMomentumUseCaseImpl, likeContent: likeContentList)
        let vc = MyContentMoreViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMyCharacterMoreViewController(votedCharacterList: [MyVotedCharacter?]) {
        let viewModel = MyCharacterMoreViewModel(coordinator: self, characters: votedCharacterList)
        let vc = MyCharacterMoreViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMyReviewMoreViewController(myReview: [MyReview?]) {
        let viewModel = MyReviewMoreViewModel(coordinator: self, myReview: myReview)
        let vc = MyReviewMoreViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMyCommentMoreViewController(myComment: [MyComment?]) {
        let viewModel = MyCommentMoreViewModel(coordinator: self, myComment: myComment)
        let vc = MyCommentMoreViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showTabmanCoordinator(character: Characters, review: ReviewList) {
        let tabmanCoordinator = TabmanCoordinator(navigationController, character: character, connectconnetTabmanCoordinatorViewController: .feed, review: review)
        tabmanCoordinator.delegate = self
        self.childCoordinators.append(tabmanCoordinator)
        tabmanCoordinator.start()
    }
}
