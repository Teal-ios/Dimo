//
//  EditPasswordViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

final class EditPasswordViewController: BaseViewController {
    
    private let editPasswordView = EditPasswordView(title: "비밀번호를 입력해주세요", placeholder: "기존 비밀번호")
    
    private var viewModel: EditPasswordViewModel
    
    //MARK: Input
    private lazy var input = EditPasswordViewModel.Input(
        currentPassWordTextFieldText: editPasswordView.idTextFieldView.tf.rx.text,
        newPasswordTextFieldText: editPasswordView.idTextFieldView.tf.rx.text,
        newPasswordCheckTextFieldText: editPasswordView.idTextFieldView.tf.rx.text,
        passwordChangeButtonTapped: editPasswordView.nextButton.rx.tap
    )
    
    override func loadView() {
        self.view = editPasswordView
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
        
        
        output.isChanged
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isChanged in
                guard let self else { return }
                if isChanged {
                    self.editPasswordView.makeToast("변경을 완료했어요", style: ToastStyle.dimo)
                    self.editPasswordView.disableChangeButton()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
