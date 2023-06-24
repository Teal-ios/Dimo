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
        let input = SignupIdentificationViewModel.Input(
            phoneNumberInput: signupIdentificationView.phoneNumberTextFieldView.tf.rx.text,
            telecomButtonTapped: signupIdentificationView.telecomButton.rx.tap,
            authInput: signupIdentificationView.authTextFieldView.tf.rx.text,
            nameInput: signupIdentificationView.nameTextFieldView.tf.rx.text,
            idRequestButtonTapped: signupIdentificationView.idRequestButton.rx.tap,
            nextButtonTapped: signupIdentificationView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.phoneNumberOutput
            .withUnretained(self)
            .bind { vc, str in
            vc.signupIdentificationView.phoneNumberTextFieldView.tf.text = vc.viewModel.phoneNumberFormat(phoneNumber: str)
        }.disposed(by: viewModel.disposeBag)
        
        output.nextButtonValid
            .withUnretained(self)
            .bind { vc, bool in
            vc.signupIdentificationView.nextButton.isEnabled = bool
            vc.signupIdentificationView.nextButton.configuration?.baseBackgroundColor = bool ? .purple100 : .black80
        }.disposed(by: disposeBag)
        
        input.nextButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                // MARK: 인증번호 체크 로직 확인할것
                vc.viewModel.timer?.invalidate()
                vc.signupIdentificationView.authNumberCheckLabel.text = "인증 번호가 올바르지 않습니다."
                
            }.disposed(by: viewModel.disposeBag)
        
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
                    UserDefaults.standard.set(button?.titleLabel?.text ?? "", forKey: "telecom")
                    
                    attrStr.font = .suitFont(ofSize: 16, weight: .Medium)
                    vc.signupIdentificationView.telecomButton.configuration?.attributedTitle = attrStr
                    vc.signupIdentificationView.telecomButton.configuration?.baseForegroundColor = .white
                    vc.signupIdentificationView.telecomSelectView.isHidden = vc.isTelecomButtonSelected
                    vc.isTelecomButtonSelected.toggle()
                }.disposed(by: disposeBag)
        }
        
        output.phoneNumberValid
            .withUnretained(self)
            .bind { vc, bool in
                vc.signupIdentificationView.idRequestButton.configuration?.baseForegroundColor = bool ? .white : .black80
                vc.signupIdentificationView.idRequestButton.isEnabled = bool
            }.disposed(by: disposeBag)
        
        output.idRequestButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.timer?.invalidate() // 타이머 초기화
                vc.viewModel.timer?.fire() // 타이머 시작
                
                vc.signupIdentificationView.authNumberCheckLabel.textColor = .error
                vc.signupIdentificationView.authTextFieldView.tf.isEnabled = true
                vc.signupIdentificationView.authTextFieldView.isHidden = false
                
                vc.viewModel.leftTime = 180 // 타이머 레이블 세팅값 설정
                vc.viewModel.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    guard vc.viewModel.leftTime! > 0 else { return }
                    vc.viewModel.leftTime! -= 1
                    let minute = "0\((vc.viewModel.leftTime ?? 0) / 60)"
                    var second = "\((vc.viewModel.leftTime ?? 0) % 60)"
                    if second.count != 2 {
                        print(second)
                        second = "0" + second
                    }
                    vc.signupIdentificationView.authNumberCheckLabel.text = minute + ":" + second
                }
            }.disposed(by: disposeBag)
    }
    
   
    
}

