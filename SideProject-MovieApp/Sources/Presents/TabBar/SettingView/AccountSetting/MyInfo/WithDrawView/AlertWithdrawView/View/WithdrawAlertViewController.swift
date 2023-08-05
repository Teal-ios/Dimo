//
//  WithdrawAlertViewController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/30.
//

import UIKit
import RxCocoa
import RxSwift

final class WithdrawAlertViewController: BaseViewController {
    
    private let selfView = CustomAlertView(title: "정말 탈퇴하시나요?", subtitle: "개인정보는 즉시 파기되고 복구할 수 없으며,\n 기타 의무 보관 정보는 관련 법령에 따라\n 일정기간 별도 보관 후 삭제됩니다.\n 또한, 탈퇴/재가입을 반복할 경우\n 사용이 제한될 수 있습니다.", okButtonTitle: "탈퇴하기")
    private var viewModel: WithdrawAlertViewModel
    private var completion: ( () -> Void )?
    
    init(viewModel: WithdrawAlertViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
    
    override func setupBinding() {
        let input = WithdrawAlertViewModel.Input(didTappedCancelButton: selfView.cancelButton.rx.tap,
                                                 didTappedwithdrawButton: selfView.okButton.rx.tap)

        let output = viewModel.transform(input: input)
        
        output.isWithdrawn
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isChanged in
                if isChanged {
   
                } else {
                    
                }
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
//    func connectAuthFlow() {
//        let scene = UIApplication.shared.connectedScenes.first
//        let windowScene = scene as? UIWindowScene
//        let window = windowScene?.windows.last
//
//        let dataTransferService = DataTransferService(networkService: NetworkService())
//        let authRepositoryImpl = AuthRepositoryImpl(dataTransferService: dataTransferService)
//        let authUseCaseImpl = AuthUseCaseImpl(authRepository: authRepositoryImpl)
//        let nav = UINavigationController(rootViewController: self)
//        let coordinator = AuthCoordinator(nav)
//        let viewModel = LoginStartViewModel(coordinator: coordinator, authUseCase: authUseCaseImpl)
//        let vc = LoginStartViewController(viewModel: viewModel)
//        let nav = UINavigationController(rootViewController: vc)
//
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.coordinator.
//
//        coordinator = AppCoordinator(nav)
//        coordinator?.start()
//    }
}
