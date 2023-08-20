//
//  SettingCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit

final class SettingCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSettingViewController()
    }
    
    func showSettingViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = SettingViewModel(coordinator: self, settingUseCase: settingUseCaseImpl)
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
    
    func showAlertEditUserNameViewController(with newNickname: String?, completion: ( () -> Void )? ) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = ChangeNicknameAlertViewModel(coordinator: self, settingUseCase: settingUseCaseImpl, newNickname: newNickname)
        let vc = ChangeNicknameAlertViewController(viewModel: viewModel, completion: completion)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }
    
    func showAlertWithdrawViewController(with withdrawReason: String) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = WithdrawAlertViewModel(coordinator: self,
                                               settingUseCase: settingUseCaseImpl,
                                               withdrawReason: withdrawReason)
        let vc = WithdrawAlertViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }
    
    func showEditPasswordViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUsecase = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = EditPasswordViewModel(coordinator: self, settingUseCase: settingUsecase)
        let vc = EditPasswordViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showEditMbtiViewController(mbti: String?, mbtiChangeDate: Date?) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUsecase = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        
        let isOverOneMonth = Date.checkOverOneMonth(from: mbtiChangeDate)
        
        if isOverOneMonth {
            let editMbtiViewModel = EditMbtiViewModel(coordinator: self, settingUseCase: settingUsecase, mbti: mbti, mbtiChangeDate: mbtiChangeDate)
            let vc = EditMbtiViewController(viewModel: editMbtiViewModel)
            navigationController.pushViewController(vc, animated: true)
        } else {
            let userMbtiViewModel = UserMbtiViewModel(mbti: mbti, mbtiChangeDate: mbtiChangeDate)
            let vc = EditMbtiViewController(viewModel: userMbtiViewModel)
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func showWithDrawViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUsecase = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = WithdrawViewModel(coordinator: self, settingUseCase: settingUsecase)
        let vc = WithdrawViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showNoticeViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUsecase = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = NoticeViewModel(coordinator: self, settingUseCase: settingUsecase)
        let vc = NoticeViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFrequentQuestionViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUsecase = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = FrequentQuestionViewModel(coordinator: self, settingUseCase: settingUsecase)
        let vc = FrequentQuestionViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func connectAuthFlow() {
        self.parentCoordinator?.parentCoordinator?.start()
    }
}
