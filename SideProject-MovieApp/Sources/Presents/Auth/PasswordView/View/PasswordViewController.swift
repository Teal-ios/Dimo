//
//  PasswordViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/04/02.
//

import UIKit
import RxCocoa

class PasswordViewController: BaseViewController {
    let passwordView = PasswordView(title: "비밀번호를 입력해 주세요", placeholder: "비밀번호")
    private var viewModel: PasswordViewModel
    
    //MARK: Input
    private lazy var input = PasswordViewModel.Input(passwordText: self.passwordView.idTextFieldView.tf.rx.text, checkpwText: self.passwordView.passwordCheckView.tf.rx.text, didNextButtonTap: self.passwordView.nextButton.rx.tap.withLatestFrom(self.passwordView.passwordCheckView.tf.rx.text.orEmpty).asSignal(onErrorJustReturn: ""))
    
    override func loadView() {
        view = passwordView
    }
    init(viewModel: PasswordViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
        output.passwordDuplicationValid.withUnretained(self).bind { vc, valid in
            let textColor: UIColor = valid ? .systemBlue : .systemRed
            vc.passwordView.passwordCheckLabel.textColor = textColor
            
            let str: String = valid ?
            "" : "비밀번호가 일치하지 않습니다."
            vc.passwordView.nextButton.isEnabled = valid
            vc.passwordView.nextButton.configuration?.baseBackgroundColor = valid ? .purple100 : .black80
            vc.passwordView.passwordCheckLabel.text = str
        }
        .disposed(by: disposeBag)
        
    }
}
