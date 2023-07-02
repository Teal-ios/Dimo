//
//  SettingCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit

final class SettingCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showSettingViewController()
    }
    
    func showSettingViewController() {
        let viewModel = SettingViewModel(coordinator: self)
        let vc = SettingViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
    
    func showEditMyInfoViewController() {
        let viewModel = EditMyInfoViewModel(coordinator: self)
        let vc = EditMyInfoViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showEditUserNameViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = EditNicknameViewModel(coordinator: self, settingUseCase: settingUseCaseImpl)
        let vc = EditNicknameViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAlertEditUserNameViewController(with newNickname: String?) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = AlertEditUserNameViewModel(coordinator: self, settingUseCase: settingUseCaseImpl, newNickname: newNickname)
        let vc = AlertEditUserNameViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }
    
    func showEditPasswordViewController() {
        let viewModel = EditPasswordViewModel(coordinator: self)
        let vc = EditPasswordViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showEditMbtiViewController() {
        let viewModel = EditMbtiViewModel(coordinator: self)
        let vc = EditMbtiViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showWithDrawViewController() {
        let viewModel = WithDrawViewModel(coordinator: self)
        let vc = WithDrawViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
