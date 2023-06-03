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
    private let nickNameView = NickNameView(title: "DIMO에서 사용할\n닉네임을 입력해 주세요", placeholder: "닉네임")
    private var viewModel: NickNameViewModel
    override func loadView() {
        view = nickNameView
    }
    init(viewModel: NickNameViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    override func setupBinding() {
        let input = NickNameViewModel.Input(textFieldInput: nickNameView.idTextFieldView.tf.rx.text, nextButtonTapped: nickNameView.nextButton.rx.tap, duplicationButtonTap: nickNameView.duplicateCheckButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.nicknameValid
            .withUnretained(self)
            .bind { vc, bool in
                vc.nickNameView.duplicateCheckButton.configuration?.baseForegroundColor = bool ? .white : .black80
                vc.nickNameView.duplicateCheckButton.isEnabled = bool
            }
            .disposed(by: disposeBag)
        
        output.nextButtonValid
            .withUnretained(self)
            .observe(on: MainScheduler.instance)  // 메인 스레드에서 실행하도록 함
            .bind { vc, bool in
            
                vc.nickNameView.policyLabel.text = bool ? "사용 가능한 닉네임입니다." : "중복된 닉네임이 존재합니다."
                vc.nickNameView.policyLabel.textColor = bool ? .black60 : .error
                vc.nickNameView.nextButton.isEnabled = bool
                vc.nickNameView.nextButton.configuration?.baseBackgroundColor = bool ? .purple100 : .black80
                vc.nickNameView.policyLabel.textColor = .black
            }.disposed(by: disposeBag)
    }
}
