//
//  IDRegisterViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/30.
//

import UIKit
import RxCocoa

class IDRegisterViewController: BaseViewController {
    

    //MARK: Delegate
    let idRegisterView = IDRegisterView(title: "아이디를 입력해주세요", placeholder: "아이디")

    //MARK: Delegate
    private var viewModel: IDNickNameViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: IDNickNameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = idRegisterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
    }
    override func setupBinding() {
        let input = IDNickNameViewModel.Input(
            textFieldInput: idRegisterView.idTextFieldView.tf.rx.text,
            nextButtonTapped: idRegisterView.nextButton.rx.tap, duplicationButtonTap: idRegisterView.duplicateCheckButton.rx.tap
        )
        let _ = viewModel.transform(input: input)
    }
}
