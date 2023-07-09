//
//  DimoViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/12.
//

import UIKit
import RxCocoa
import SnapKit
import Toast

class DimoLoginViewController: BaseViewController {
    
    private let dimoLoginView = DimoLoginView(title: "당신의 과몰입을\n완성해 보세요", placeholder: "아이디")
    private var viewModel: DimoLoginViewModel
    
    override func loadView() {
        view = dimoLoginView
    }
    
    init(viewModel: DimoLoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    override func setupBinding() {
        navigationController?.isNavigationBarHidden = false

        let input = DimoLoginViewModel.Input(nextButtonTapped: dimoLoginView.nextButton.rx.tap, idText: dimoLoginView.idTextFieldView.tf.rx.text, passwordText: dimoLoginView.passwordView.tf.rx.text, idFindButtonTapped: dimoLoginView.idFindButton.rx.tap, pwFindButtonTapped: dimoLoginView.passwordFindButton.rx.tap, dimoFirstStartButtonTapped: dimoLoginView.firstDimoButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.loginValid
            .withUnretained(self)
            .bind { vc, valid in
                vc.dimoLoginView.nextButton.isEnabled = valid
                vc.dimoLoginView.nextButton.configuration?
                    .baseBackgroundColor = valid ? .purple100 : .black80
            }.disposed(by: disposeBag)
        
        output.toastMessage
            .bind { message in
                self.dimoLoginView.makeToast(message, style: ToastStyle.dimoToastStyle)
            }
            .disposed(by: disposeBag)
    }
}
