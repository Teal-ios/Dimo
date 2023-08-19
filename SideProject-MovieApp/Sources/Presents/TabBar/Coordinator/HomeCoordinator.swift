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
        //        if childCoordinator.type == .myPage {
        //            self.navigationController.viewControllers.removeAll()
        //            self.delegate?.didFinish(childCoordinator: self)
        //        }
    }
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeViewController(category: "애니")
    }
    
    func showHomeViewController(category: String) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let contentRepositoryImpl = ContentRepositoryImpl(dataTransferService: dataTransferService)
        let contentUseCaseImpl = ContentUseCaseImpl(contentRepository: contentRepositoryImpl)
        let viewModel = HomeViewModel(coordinator: self, contentUseCase: contentUseCaseImpl, category: category)
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
    
    func showTabmanCoordinator(character: Characters) {
        let tabmanCoordinator = TabmanCoordinator(navigationController, character: character)
        tabmanCoordinator.delegate = self
        self.childCoordinators.append(tabmanCoordinator)
        tabmanCoordinator.start()
    }
    
    func showContentMoreViewController(title: String, content: [Hit]) {
        let viewModel = ContentMoreViewModel(coordinator: self, content: content)
        let vc = ContentMoreViewController(viewModel: viewModel, title: title)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMovieDetailViewController(content_id: String) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let contentRepositoryImpl = ContentRepositoryImpl(dataTransferService: dataTransferService)
        let contentUseCaseImpl = ContentUseCaseImpl(contentRepository: contentRepositoryImpl)
        let viewModel = MovieDetailViewModel(coordinator: self, contentUseCase: contentUseCaseImpl, content_id: content_id)
        let vc = MovieDetailViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCharacterMoreViewController() {
        let viewModel = CharacterMoreViewModel(coordinator: self)
        let vc = CharacterMoreViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMovieDetailEvaluateViewController() {
        let viewModel = MovieDetailEvaluateViewModel(coordinator: self)
        let vc = MovieDetailEvaluateViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
}
