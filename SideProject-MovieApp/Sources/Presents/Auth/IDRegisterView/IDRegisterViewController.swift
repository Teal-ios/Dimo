//
//  IDRegisterViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/30.
//

import UIKit
import RxSwift
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
        let output = viewModel.transform(input: input)
        output.idValid
            .withUnretained(self)
            .bind { vc, bool in
                vc.idRegisterView.duplicateCheckButton.configuration?.baseForegroundColor = bool ? .white : .black80
                vc.idRegisterView.duplicateCheckButton.isEnabled = bool
            }
            .disposed(by: disposeBag)
        output.nextButtonValid
            .withUnretained(self)
            .observe(on: MainScheduler.instance)  // 메인 스레드에서 실행하도록 함
            .bind { vc, bool in
                vc.idRegisterView.nextButton.isEnabled = bool
                vc.idRegisterView.nextButton.configuration?.baseBackgroundColor = bool ? .purple100 : .black80
                
                vc.idRegisterView.policyLabel.text = bool ? "사용 가능한 아이디입니다." : "중복 확인이 필요합니다."
                vc.idRegisterView.policyLabel.textColor = bool ? .black60 : .error
            }
            .disposed(by: disposeBag)
    }
}
