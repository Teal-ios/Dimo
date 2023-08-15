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
        currentPasswordTextFieldBenginEditing: editPasswordView.currentPasswordView.tf.rx.controlEvent(.editingDidBegin),
        currentPassWordTextFieldText: editPasswordView.currentPasswordView.tf.rx.text,
        newPasswordTextFieldTextBeginEditing: editPasswordView.newPasswordView.tf.rx.controlEvent(.editingDidBegin) ,
        newPasswordTextFieldText: editPasswordView.newPasswordView.tf.rx.text,
        newPasswordCheckTextFieldTextBeginEditing: editPasswordView.newPasswordCheckView.tf.rx.controlEvent(.editingDidBegin),
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
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
        output.isChanged
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isChanged in
                guard let self else { return }
                if isChanged {
                    self.editPasswordView.makeToast("변경을 완료했어요", style: ToastStyle.dimo)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        output.isChangeable
            .bind { [weak self] (isValidPasswordFormat, isSameWithNewPassword) in
                guard let self else { return }
                guard let isValidPasswordFormat = isValidPasswordFormat,
                      let isSameWithNewPassword = isSameWithNewPassword else { return }
                if isValidPasswordFormat && isSameWithNewPassword {
                    self.editPasswordView.enableChangeButton()
                } else {
                    self.editPasswordView.disableChangeButton()
                }
            }
            .disposed(by: disposeBag)
        
        output.isSameWithNewPassword
            .withUnretained(self)
            .bind { (vc, isSame) in
                vc.editPasswordView.showNewPasswordTextFieldState(isSame)
            }
            .disposed(by: disposeBag)

        output.isValidPasswordFormat
            .withUnretained(self)
            .bind { (vc, isValid) in
                self.editPasswordView.showPasswordValidationTextFieldState(isValid)
            }
            .disposed(by: disposeBag)
        
        output.isEmptyNewPasswordCheckTextField
            .withUnretained(self)
            .bind { (vc, isEmpty) in
                if isEmpty {
                    self.editPasswordView.showPasswordValidationTextFieldState(true)
                }
            }
            .disposed(by: disposeBag)
        
        output.newPasswordIsSameWithCurrentPassword
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { (vc, isSame) in
                self.editPasswordView.showPasswordValidationTextFieldState(isSame: isSame)
            }
            .disposed(by: disposeBag)
        
        output.isSameWithCurrentPassword
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isSame in
                guard let self else { return }
                self.editPasswordView.showExistingPasswordTextFieldState(isSame)
            }
            .disposed(by: disposeBag)
        
        output.currentPasswordTextFieldText
            .withUnretained(self)
            .bind { (vc, text) in
                vc.editPasswordView.currentPasswordView.tf.text = text
            }
            .disposed(by: disposeBag)
        
        output.newPasswordTextFieldText
            .withUnretained(self)
            .bind { (vc, text) in
                vc.editPasswordView.newPasswordView.tf.text = text
            }
            .disposed(by: disposeBag)
        
        output.newPasswordCheckTextFieldText
            .withUnretained(self)
            .bind { (vc, text) in
                vc.editPasswordView.newPasswordCheckView.tf.text = text
            }
            .disposed(by: disposeBag)
    }
}
