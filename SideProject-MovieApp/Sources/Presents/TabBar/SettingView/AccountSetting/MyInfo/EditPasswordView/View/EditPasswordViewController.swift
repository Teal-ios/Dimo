//
//  EditPasswordViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class EditPasswordViewController: BaseViewController {
    
    private let editPasswordView = EditPasswordView()
    
    private var viewModel: EditPasswordViewModel
    
    private lazy var input = EditPasswordViewModel.Input(
        currentPassWordTextFieldText: editPasswordView.currentPasswordView.tf.rx.text,
        newPasswordTextFieldText: editPasswordView.newPasswordView.tf.rx.text,
        newPasswordCheckTextFieldText: editPasswordView.newPasswordCheckView.tf.rx.text,
        passwordChangeButtonTapped: editPasswordView.passwordChangeButton.rx.tap
    )
    
    override func loadView() {
        self.view = editPasswordView
    }
    
    init(viewModel: EditPasswordViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
        output.isChanged
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isChanged in
                guard let self else { return }
                if isChanged {
                    self.editPasswordView.makeToast("변경을 완료했어요", style: ToastStyle.dimo)
                    self.editPasswordView.disableChangeButton()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        output.passwordChageButtonTappedOutput
            .observe(on: MainScheduler.instance)
            .bind { [weak self] (isSameWithExistingPassword, isValidPasswordFormat, isSameWithNewPassword) in
                guard let self else { return }
                self.editPasswordView.showExistingPasswordTextFieldState(isSameWithExistingPassword)
                self.editPasswordView.showPasswordValidationTextFieldState(isValidPasswordFormat)
                self.editPasswordView.showNewPasswordTextFieldState(isSameWithNewPassword)
            }
            .disposed(by: disposeBag)
    }
}
