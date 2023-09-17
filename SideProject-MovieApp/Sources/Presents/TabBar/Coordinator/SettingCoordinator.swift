//
//  SettingCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit

final class SettingCoordinator: Coordinator, CoordinatorDelegate {
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
    
    func showEditMyInfoViewController(nicknameChangeDate: Date?) {
        let viewModel = EditMyInfoViewModel(coordinator: self, nicknameChangeDate: nicknameChangeDate)
        let vc = EditMyInfoViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showEditNicknameViewController(nicknameChangeDate: Date?) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = EditNicknameViewModel(coordinator: self, settingUseCase: settingUseCaseImpl, nicknameChangeDate: nicknameChangeDate)
        let vc = EditNicknameViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAlertEditUserNameViewController(with newNickname: String?, completion: ( () -> Void )? ) {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = EditNicknameAlertViewModel(coordinator: self, settingUseCase: settingUseCaseImpl, newNickname: newNickname)
        let vc = EditNicknameAlertViewController(viewModel: viewModel, completion: completion)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }
    
    func showPushNotificationSettingViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = PushNotificationSettingViewModel(coordinator: self, networkUsecase: settingUseCaseImpl)
        let vc = PushNotificationSettingViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showKeywordNotificationViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUseCaseImpl = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)

        let productNotificationViewModel = ProductNotificationViewModel(coordinator: self, networkUsecase: settingUseCaseImpl)
        let mbtiNotificationViewModel = MBTINotificationViewModel(coordinator: self, networkUsecase: settingUseCaseImpl)
        
        let productNotificationViewController = ProductNotificationViewController(viewModel: productNotificationViewModel)
        let mbtiNotificationViewController = MBTIKeywordNotificationViewController(viewModel: mbtiNotificationViewModel)
        
        let viewModel = KeywordNotificationViewModel(coordinator: self)
        let viewControllers = [productNotificationViewController, mbtiNotificationViewController]
        let vc = KeywordNotificationViewController(with: viewModel, viewControllers)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
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
    
    func showCharacterAskViewController() {
        let dataTransferService = DataTransferService(networkService: NetworkService())
        let settingRepositoryImpl = SettingRepositoryImpl(dataTransferService: dataTransferService)
        let settingUsecase = SettingUseCaseImpl(settingRepository: settingRepositoryImpl)
        let viewModel = CharacterAskViewModel(coordinator: self, settingUseCase: settingUsecase)
        let vc = CharacterAskViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSortActionSheetController(_ characterNameSortButtonAction: UIAction,
                                       _ productionTitleSortAction: UIAction) {
        let vc = SortActionSheetViewController(characterNameSortButtonAction, productionTitleSortAction)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func connectAuthFlow() {
        self.parentCoordinator?.parentCoordinator?.start()
    }
}
