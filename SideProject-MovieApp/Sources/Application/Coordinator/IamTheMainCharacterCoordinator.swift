//
//  IamTheMainCharacterCoordinator.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/21.
//

//import UIKit
//
//final class IamTheMainCharacterCoordinator: Coordinator {
//
//    var childCoordinators = [Coordinator]()
//    var navigationController: UINavigationController
//    var window: UIWindow
//
//    init(window: UIWindow) {
//        self.navigationController = UINavigationController()
//        self.window = window
//    }
//
//    func start() {
//        let vc = IamTheMainCharacterViewController()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: false)
//        print(childCoordinators)
//    }
//    /// cell 탭했을 때 화면전환 메서드 추가 되어야함
//}

//import UIKit
//
//final class IamTheMainCharacterCoordinator: Coordinator {
//    weak var delegate: CoordinatorDelegate?
//    var childCoordinators = [Coordinator]()
//    var navigationController: UINavigationController
//    var type: CoordinatorStyleCase = .auth
//    
//    private let userDefaults = UserDefaults.standard
//
//    init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        showOnboardingViewController()
//    }
//    
//    func showOnboardingViewController() {
//        let viewModel = OnBoardingViewModel(coordinator: self)
//        let vc = OnBoardingViewController(viewModel: viewModel)
//        navigationController.viewControllers = [vc]
//    }
//
//}
