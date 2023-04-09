//
//  PasswordViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/04/02.
//

import UIKit

class PasswordViewController: BaseViewController {
    let passwordView = PasswordView(title: "비밀번호를 입력해 주세요", placeholder: "비밀번호")
    /// 임시 패스워드 뷰 모델로 바꾸어 주어야함
    private var viewModel: IDNickNameViewModel
    
    override func loadView() {
        view = passwordView
    }
    init(viewModel: IDNickNameViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupBinding() {
        let input = IDNickNameViewModel.Input(nextButtonTapped: passwordView.nextButton.rx.tap)
        let _ = viewModel.transform(input: input)
    }
}
