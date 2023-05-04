//
//  HomeTabBarCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/30.
//

import UIKit

final class HomeTabBarCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var type: CoordinatorStyleCase = .tab
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let pages: [TabBarPageCase] = TabBarPageCase.allCases
        let controllers: [UINavigationController] = pages.map({
            self.createTabNavigationController(of: $0)
        })
        self.configureTabBarController(with: controllers)
    }
    
    func currentPage() -> TabBarPageCase? {
        TabBarPageCase(index: self.tabBarController.selectedIndex)
    }
    
    func selectPage(_ page: TabBarPageCase) {
        self.tabBarController.selectedIndex = page.pageOrderNumber
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPageCase(index: index) else { return }
        self.tabBarController.selectedIndex = page.pageOrderNumber
    }
    
    private func configureTabBarController(with tabViewControllers: [UIViewController]) {
        self.tabBarController.setViewControllers(tabViewControllers, animated: true)
        self.tabBarController.selectedIndex = TabBarPageCase.home.pageOrderNumber
        self.tabBarController.view.backgroundColor = .systemBackground
        self.tabBarController.tabBar.backgroundColor = .systemBackground
        self.tabBarController.tabBar.tintColor = .black20
        self.tabBarController.tabBar.unselectedItemTintColor = .black60
        self.changeAnimation()
        self.navigationController.pushViewController(tabBarController, animated: true)
    }
    
    private func configureTabBarItem(of page: TabBarPageCase) -> UITabBarItem {
        return UITabBarItem(
            title: nil,
            image: UIImage(named: page.tabIconName()),
            tag: page.pageOrderNumber
        )
    }
    
    private func createTabNavigationController(of page: TabBarPageCase) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        tabNavigationController.tabBarItem = self.configureTabBarItem(of: page)
        connectTabCoordinator(of: page, to: tabNavigationController)
        return tabNavigationController
    }
    
    private func connectTabCoordinator(of page: TabBarPageCase, to tabNavigationController: UINavigationController) {
        switch page {
        case .home:
            let homeCoordinator = HomeCoordinator(tabNavigationController)
            homeCoordinator.delegate = self
            self.childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
            
        case .check:
            let voteCoordinator = VoteCoordinator(tabNavigationController)
            voteCoordinator.delegate = self
            self.childCoordinators.append(voteCoordinator)
            voteCoordinator.start()
            
        case .profile:
            let myMomentumCoordinator = MyMomentumCoordinator(tabNavigationController)
            myMomentumCoordinator.delegate = self
            self.childCoordinators.append(myMomentumCoordinator)
            myMomentumCoordinator.start()
        case .setting:
            print("추후")
        }
    }
}

extension HomeTabBarCoordinator: CoordinatorDelegate {
    
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        //        if childCoordinator.type == .myPage {
        //            self.navigationController.viewControllers.removeAll()
        //            self.delegate?.didFinish(childCoordinator: self)
        //        }
    }
}
