//
//  MyMomentumCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit

final class MyMomentumCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showMyMomentumViewController()
    }
    
    func showMyMomentumViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let myMomentumRepositoryImpl = MyMomentumRepositoryImpl(dataTransferService: dataTransferService)
        let myMomentumUseCaseImpl = MyMomentumUseCaseImpl(myMomentumRepository: myMomentumRepositoryImpl)
        let viewModel = MyMomentumViewModel(coordinator: self, myMomentumUseCase: myMomentumUseCaseImpl)
        let vc = MyMomentumViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
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
}
