//
//  EditUserNameViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxCocoa

final class EditUserNameViewController: BaseViewController {
    

    //MARK: Delegate
    let selfView = EditUserNameView(title: "닉네임 변경", placeholder: "새로운 닉네임")

    //MARK: Delegate
    private var viewModel: EditUserNameViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: EditUserNameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupBinding() {
        let input = EditUserNameViewModel.Input(
            textFieldInput: selfView.idTextFieldView.tf.rx.text,
            nextButtonTapped: selfView.nextButton.rx.tap
        )
        let _ = viewModel.transform(input: input)
    }
}
