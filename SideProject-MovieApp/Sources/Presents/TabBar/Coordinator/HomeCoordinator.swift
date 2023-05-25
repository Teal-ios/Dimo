//
//  HomeCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit

final class HomeCoordinator: Coordinator, CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        //        if childCoordinator.type == .myPage {
        //            self.navigationController.viewControllers.removeAll()
        //            self.delegate?.didFinish(childCoordinator: self)
        //        }
    }
    
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showHomeViewController()
    }
    
    func showHomeViewController() {
        let viewModel = HomeViewModel(coordinator: self)
        let vc = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
    
    func showCategoryViewController() {
        let viewModel = CategoryViewModel(coordinator: self)
        let vc = CategoryViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissCategoryViewController() {
        navigationController.dismiss(animated: true)
    }
  
  func showTabmanCoordinator() {
    let tabmanCoordinator = TabmanCoordinator(navigationController)
    tabmanCoordinator.delegate = self
    self.childCoordinators.append(tabmanCoordinator)
    tabmanCoordinator.start()
  }
    
//    func showCharacterDetailViewController() {
//        let tabmanCoordinator = TabmanCoordinator(navigationController)
//        tabmanCoordinator.delegate = self
//        self.childCoordinators.append(tabmanCoordinator)
//        tabmanCoordinator.start()
//    }
    
    func showContentMoreViewController(title: String) {
        let viewModel = ContentMoreViewModel(coordinator: self)
        let vc = ContentMoreViewController(viewModel: viewModel, title: title)
        navigationController.pushViewController(vc, animated: true)
    }
}
