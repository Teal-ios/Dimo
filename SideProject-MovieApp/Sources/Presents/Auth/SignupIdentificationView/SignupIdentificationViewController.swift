//
//  SignupIdentificationViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit
import RxCocoa
import RxSwift

class SignupIdentificationViewController: BaseViewController {

    //MARK: Delegate
    let signupIdentificationView = SignupIdentificationView()

    private var viewModel: SignupIdentificationViewModel
    
    private var isTelecomButtonSelected: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: SignupIdentificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = signupIdentificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
    }
    override func setupBinding() {
//        signupIdentificationView.telecomButton.rx
        let input = SignupIdentificationViewModel.Input(
            phoneNumberInput: signupIdentificationView.phoneNumberTextFieldView.tf.rx.text,
            telecomButtonTapped: signupIdentificationView.telecomButton.rx.tap,
            authInput: signupIdentificationView.authTextFieldView.tf.rx.text,
            nameInput: signupIdentificationView.nameTextFieldView.tf.rx.text,
            nextButtonTapped: signupIdentificationView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        output.phoneNumberOutput.bind { [weak self] str in
            self?.signupIdentificationView.phoneNumberTextFieldView.tf.text = self?.viewModel.phoneNumberFormat(phoneNumber: str)
        }.disposed(by: viewModel.disposebag)
        output.nextButtonValid.bind { [weak self] bool in
            self?.signupIdentificationView.nextButton.isEnabled = bool
            self?.signupIdentificationView.nextButton.configuration?.baseBackgroundColor = bool ? .purple100 : .black80
        }.disposed(by: disposeBag)
        
        // telecom Button Test
        output.telecomButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.signupIdentificationView.telecomSelectView.isHidden = vc.isTelecomButtonSelected
                vc.isTelecomButtonSelected.toggle()
            }.disposed(by: disposeBag)
        
        for i in signupIdentificationView.telecomSelectView.arrangedSubviews {
            guard let button = i as? UIButton? else { break }
            button?.rx.tap
                .withUnretained(self)
                .bind { vc, _ in
                    var attrStr = AttributedString(button?.titleLabel?.text ?? "")
                    attrStr.font = .suitFont(ofSize: 16, weight: .Medium)
                    vc.signupIdentificationView.telecomButton.configuration?.attributedTitle = attrStr
                    vc.signupIdentificationView.telecomButton.configuration?.baseForegroundColor = .white
                    vc.signupIdentificationView.telecomSelectView.isHidden = vc.isTelecomButtonSelected
                    vc.isTelecomButtonSelected.toggle()
                }.disposed(by: disposeBag)
        }
    }
    
}
