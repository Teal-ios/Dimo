//
//  FindIDViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import UIKit
import RxCocoa
import RxSwift

final class FindIDViewController: BaseViewController {
    
    //MARK: Delegate
    let findIDView = FindIDView()
    
    private var viewModel: FindIDViewModel
    
    private var isTelecomButtonSelected: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: FindIDViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = findIDView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()

    }
    
    override func setupBinding() {
        let input = FindIDViewModel.Input(
            phoneNumberInput: findIDView.phoneNumberTextFieldView.tf.rx.text,
            telecomButtonTapped: findIDView.telecomButton.rx.tap,
            authInput: findIDView.authTextFieldView.tf.rx.text,
            nameInput: findIDView.nameTextFieldView.tf.rx.text,
            idRequestButtonTapped: findIDView.idRequestButton.rx.tap,
            nextButtonTapped: findIDView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.phoneNumberOutput
            .withUnretained(self)
            .bind { vc, str in
                vc.findIDView.phoneNumberTextFieldView.tf.text = vc.viewModel.phoneNumberFormat(phoneNumber: str)
            }.disposed(by: viewModel.disposeBag)
        
        output.nextButtonValid
            .withUnretained(self)
            .bind { vc, bool in
                vc.findIDView.nextButton.isEnabled = bool
                vc.findIDView.nextButton.configuration?.baseBackgroundColor = bool ? .purple100 : .black80
            }.disposed(by: disposeBag)
        
        input.nextButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                // MARK: 인증번호 체크 로직 확인할것
                vc.viewModel.timer?.invalidate()
                vc.findIDView.authNumberCheckLabel.text = "인증 번호가 올바르지 않습니다."
                
            }.disposed(by: viewModel.disposeBag)
        
        output.telecomButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.findIDView.telecomSelectView.isHidden = vc.isTelecomButtonSelected
                vc.isTelecomButtonSelected.toggle()
            }.disposed(by: disposeBag)
        
        for i in findIDView.telecomSelectView.arrangedSubviews {
            guard let button = i as? UIButton? else { break }
            button?.rx.tap
                .withUnretained(self)
                .bind { vc, _ in
                    var attrStr = AttributedString(button?.titleLabel?.text ?? "")
                    attrStr.font = .suitFont(ofSize: 16, weight: .Medium)
                    vc.findIDView.telecomButton.configuration?.attributedTitle = attrStr
                    vc.findIDView.telecomButton.configuration?.baseForegroundColor = .white
                    vc.findIDView.telecomSelectView.isHidden = vc.isTelecomButtonSelected
                    vc.isTelecomButtonSelected.toggle()
                }.disposed(by: disposeBag)
        }
        
        output.phoneNumberValid
            .withUnretained(self)
            .bind { vc, bool in
                vc.findIDView.idRequestButton.configuration?.baseForegroundColor = bool ? .white : .black80
                vc.findIDView.idRequestButton.isEnabled = bool
            }.disposed(by: disposeBag)
        
        
        output.idRequestButtonTapped
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.timer?.invalidate()
                vc.viewModel.timer?.fire() // 타이머 시작
                
                vc.findIDView.authNumberCheckLabel.textColor = .error
                vc.findIDView.authTextFieldView.tf.isEnabled = true
                vc.findIDView.authTextFieldView.isHidden = false
                
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
                    vc.findIDView.authNumberCheckLabel.text = minute + ":" + second
                }
            }.disposed(by: disposeBag)
    }
}
