//
//  NickNameViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/31.
//

import UIKit
import RxCocoa

class NickNameViewController: BaseViewController {
    private let nickNameView = NickNameView(title: "DIMO에서 사용할\n닉네임을 입력해 주세요", placeholder: "닉네임")
    private var viewModel: IDNickNameViewModel
    override func loadView() {
        view = nickNameView
    }
    init(viewModel: IDNickNameViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    override func setupBinding() {
        let input = IDNickNameViewModel.Input(
            textFieldInput: nickNameView.idTextFieldView.tf.rx.text ,nextButtonTapped: nickNameView.nextButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        output.idNickNameValid
            .withUnretained(self)
            .bind { vc, bool in
                guard bool.policy && bool.repeatCheck else {
                    if !bool.policy {
                        vc.nickNameView.policyLabel.text = "사용할 수 없는 아이디입니다."
                    }
                    if !bool.repeatCheck {
                        vc.nickNameView.policyLabel.text = "중복된 닉네임이 존재합니다."
                    }
                    vc.nickNameView.policyLabel.textColor = .error
                    return
                }
                vc.nickNameView.policyLabel.textColor = .black
                vc.nickNameView.nextButton.isEnabled = bool.policy
            }.disposed(by: disposeBag)
    }
}
