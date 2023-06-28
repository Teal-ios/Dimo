//
//  EditUserNameViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxCocoa

final class EditNicknameViewController: BaseViewController {
    
    let editNicknameView = EditNicknameView(title: "닉네임 변경", placeholder: "새로운 닉네임")

    private var viewModel: EditNicknameViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: EditNicknameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = editNicknameView
    }
    
    override func setupBinding() {
        let input = EditNicknameViewModel.Input(
            textFieldEdited: editNicknameView.idTextFieldView.tf.rx.text,
            nicknameDuplicationButtonTapped: editNicknameView.duplicationCheckButton.rx.tap,
            nextButtonTapped: editNicknameView.nextButton.rx.tap
        )
        let _ = viewModel.transform(input: input)
    }
}
