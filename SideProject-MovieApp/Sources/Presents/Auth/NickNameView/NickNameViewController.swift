//
//  NickNameViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/31.
//

import UIKit
import RxCocoa
import RxSwift

class NickNameViewController: BaseViewController {
    
    private let nicknameView = NicknameView(title: "DIMO에서 사용할\n닉네임을 입력해 주세요", placeholder: "닉네임")
    private var viewModel: NicknameViewModel
    
    init(viewModel: NicknameViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        self.view = nicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    override func setupBinding() {
        let input = NicknameViewModel.Input(
            textFieldEditingDidBegin: nicknameView.idTextFieldView.tf.rx.controlEvent(.editingDidBegin),
            textFieldEditingChanged: nicknameView.idTextFieldView.tf.rx.controlEvent(.editingChanged),
            textFieldEditingDidEnd: nicknameView.idTextFieldView.tf.rx.controlEvent(.editingDidEnd),
            textFieldInput: nicknameView.idTextFieldView.tf.rx.text,
            didTappedNextButton: nicknameView.nextButton.rx.tap
        )

        let output = viewModel.transform(input: input)
        
        output.isTextFieldEditingDidBegin
            .bind { [weak self] isEditingBegin in
                if isEditingBegin {
                    self?.nicknameView.showEmptyMessage()
                }
            }
            .disposed(by: disposeBag)
        
        output.isTextFieldChanged
            .bind { [weak self] isEditingChanged in
                self?.nicknameView.checkNextButton(isValid: false)
            }
            .disposed(by: disposeBag)
        
        output.isTextFieldEditingChanged
            .skip(1)
            .bind { [weak self] isValidFormat in
                if isValidFormat == false {
                    self?.nicknameView.showUnvalidNicknameFormatMessage()
                } else {
                    self?.nicknameView.showEmptyMessage()
                }
            }
            .disposed(by: disposeBag)
        
        output.isDuplicatedNickname
            .observe(on: MainScheduler.instance)
            .skip(1)
            .bind { [weak self] isDuplicatedNickname in
                if isDuplicatedNickname {
                    self?.nicknameView.showDuplicatedNicknameMessage()
                } else {
                    self?.nicknameView.showValidNicknameMessage()
                    self?.nicknameView.checkNextButton(isValid: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
