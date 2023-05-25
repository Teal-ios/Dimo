//
//  EditPasswordViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxCocoa

final class EditPasswordViewController: BaseViewController {
    let selfView = EditPasswordView(title: "비밀번호를 입력해주세요", placeholder: "기존 비밀번호")
    
    private var viewModel: EditPasswordViewModel
    
    //MARK: Input
    private lazy var input = EditPasswordViewModel.Input(passwordText: self.selfView.idTextFieldView.tf.rx.text, checkpwText: self.selfView.newPasswordCheckView.tf.rx.text, didNextButtonTap: self.selfView.nextButton.rx.tap.withLatestFrom(self.selfView.newPasswordCheckView.tf.rx.text.orEmpty).asSignal(onErrorJustReturn: ""))
    
    override func loadView() {
        view = selfView
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
        
        output.passwordDuplicationValid.withUnretained(self).bind { vc, valid in
            let textColor: UIColor = valid ? .systemBlue : .systemRed
            vc.selfView.newPasswordCheckLabel.textColor = textColor
            
            let str: String = valid ?
            "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다."
            
            vc.selfView.newPasswordCheckLabel.text = str
            
        }
        .disposed(by: disposeBag)
    }
    
}
