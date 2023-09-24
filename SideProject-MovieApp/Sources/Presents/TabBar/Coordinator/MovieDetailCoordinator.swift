//
//  MovieDetailCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/24.
//

import UIKit
import RxCocoa

final class MovieDetailCoordinator: Coordinator, CoordinatorDelegate, sendEvaluateFinishDelegate {
    
    
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    var content_id: String
    
    init(_ navigationController: UINavigationController, content_id: String) {
        self.navigationController = navigationController
        self.content_id = content_id
    }
    
    var gradeFinish = PublishRelay<Int>()

    func start() {
        showMovieDetailViewController(content_id: content_id)
    }
    
    func showMovieDetailViewController(content_id: String) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let contentRepositoryImpl = ContentRepositoryImpl(dataTransferService: dataTransferService)
        let contentUseCaseImpl = ContentUseCaseImpl(contentRepository: contentRepositoryImpl)
        let viewModel = MovieDetailViewModel(coordinator: self, contentUseCase: contentUseCaseImpl, content_id: content_id, gradeFinish: gradeFinish)
        let vc = MovieDetailViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func showTabmanCoordinator(character: Characters) {
        let tabmanCoordinator = TabmanCoordinator(navigationController, character: character, connectconnetTabmanCoordinatorViewController: .tabman, review: nil)
        tabmanCoordinator.delegate = self
        self.childCoordinators.append(tabmanCoordinator)
        tabmanCoordinator.start()
    }
    
    func showMovieDetailEvaluateViewController(content_id: String) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let contentRepositoryImpl = ContentRepositoryImpl(dataTransferService: dataTransferService)
        let contentUseCaseImpl = ContentUseCaseImpl(contentRepository: contentRepositoryImpl)
        let viewModel = MovieDetailEvaluateViewModel(coordinator: self, contentUseCase: contentUseCaseImpl, content_id: content_id)
        viewModel.delegate = self
        let vc = MovieDetailEvaluateViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showCharacterMoreViewController(characterData: [SameMbtiCharacter]) {
        
        let characterMoreCoordinatpr = CharacterMoreCoordinator(navigationController, characterData: characterData)
        characterMoreCoordinatpr.delegate = self
        self.childCoordinators.append(characterMoreCoordinatpr)
        characterMoreCoordinatpr.start()
    }
    
    func showMovieCharacterMoreViewController(characters: [Characters?]) {
        let viewModel = MovieCharacterMoreViewModel(coordinator: self, characters: characters)
        let vc = MovieCharacterMoreViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MovieDetailCoordinator {
    func sendEvaluateFinishAfter(grade: Int) {
        self.gradeFinish.accept(grade)

    }
}
