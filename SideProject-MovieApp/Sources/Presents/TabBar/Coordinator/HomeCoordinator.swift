//
//  HomeCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeCoordinator: Coordinator, CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

    }
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var gradeFinish = PublishRelay<Int>()
    
    func start() {
        showHomeViewController(category: "애니")
    }
    
    func showHomeViewController(category: String) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let contentRepositoryImpl = ContentRepositoryImpl(dataTransferService: dataTransferService)
        let contentUseCaseImpl = ContentUseCaseImpl(contentRepository: contentRepositoryImpl)
        let myMomentumRepository = MyMomentumRepositoryImpl(dataTransferService: dataTransferService)
        let myMomentumUseCase = MyMomentumUseCaseImpl(myMomentumRepository: myMomentumRepository)
        let viewModel = HomeViewModel(coordinator: self, contentUseCase: contentUseCaseImpl, myMomentumUseCase: myMomentumUseCase, category: category)
        let vc = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
    
    func showCategoryViewController(category: BehaviorRelay<String>) {
        let viewModel = CategoryViewModel(coordinator: self, category: category)
        let vc = CategoryViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func showContentMoreViewController(title: String, content: [Hit]) {
        let viewModel = ContentMoreViewModel(coordinator: self, content: content)
        let vc = ContentMoreViewController(viewModel: viewModel, title: title)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMovieDetailViewController(content_id: String) {
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController, content_id: content_id)
        movieDetailCoordinator.delegate = self
        self.childCoordinators.append(movieDetailCoordinator)
        movieDetailCoordinator.start()
    }
    
    func showCharacterMoreViewController(characterData: [SameMbtiCharacter]) {
        let characterMoreCoordinatpr = CharacterMoreCoordinator(navigationController, characterData: characterData)
        characterMoreCoordinatpr.delegate = self
        self.childCoordinators.append(characterMoreCoordinatpr)
        characterMoreCoordinatpr.start()
    }
}

extension HomeCoordinator: sendEvaluateFinishDelegate {
    func sendEvaluateFinishAfter(grade: Int) {
        self.gradeFinish.accept(grade)
    }
}
