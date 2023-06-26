//
//  SignupIdentificationView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit
import SnapKit

final class SignupIdentificationView: BaseView {
    let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "본인 인증해 주세요"
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    let nameTextFieldView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "이름")
    }()
    
    let telecomButton: TelecomButton = {
        return TelecomButton(title: "통신사", foregroundColor: .black80)
    }()
    let sktButton: TelecomButton = {
        return TelecomButton(title: "SKT", foregroundColor: .black5)
    }()
    let ktButton: TelecomButton = {
        return TelecomButton(title: "KT", foregroundColor: .black5)
    }()
    let uplusButton: TelecomButton = {
        return TelecomButton(title: "LGU+", foregroundColor: .black5)
    }()
    let extraTelecomButton: TelecomButton = {
        return TelecomButton(title: "알뜰폰", foregroundColor: .black5)
    }()
    let authNumberCheckLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .suitFont(ofSize: 12)
        return label
    }()
    let telecomSelectView: UIStackView = {
        let view = UIStackView()
        view.isHidden = true
        view.distribution = .fillEqually
        view.spacing = 0
        view.axis = .vertical
        view.backgroundColor = .black80
        view.layer.cornerRadius = 8
        return view
    }()
    let phoneNumberTextFieldView: OnboardingTextFieldView = {
        let view = OnboardingTextFieldView(placeholder: "전화 번호")
        view.tf.keyboardType = .decimalPad
        return view
    }()
    
    let idRequestButton: OnboardingButton = {
        let button = OnboardingButton(title: "인증요청")
        button.configuration?.baseBackgroundColor = .black100
        button.configuration?.baseForegroundColor = .black5
        return button
    }()
    let authTextFieldView: OnboardingTextFieldView = {
        let view = OnboardingTextFieldView(placeholder: "인증 번호")
        view.tf.isEnabled = false
        view.isHidden = true
        view.tf.keyboardType = .decimalPad
        return view
    }()
    let nextButton: OnboardingButton = {
        return OnboardingButton(title: "다음", ofSize: 14)
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func setupLayout() {
        let topLeading: CGFloat = 16
        let betweenTerms: CGFloat = 36
        let insidePadding: CGFloat = 8
        let betweenTextFieldViews: CGFloat = 24
        let textFieldHeight: CGFloat = 52
        let buttonHeight: CGFloat = 48
        [termsLabel,
         nameTextFieldView,
         telecomButton,
         phoneNumberTextFieldView,
         authTextFieldView,
         authNumberCheckLabel,
         telecomSelectView,
         nextButton]
            .forEach { self.addSubview($0) }
        
        phoneNumberTextFieldView.addSubview(idRequestButton)
        telecomSelectView.addArrangedSubview(sktButton)
        telecomSelectView.addArrangedSubview(ktButton)
        telecomSelectView.addArrangedSubview(uplusButton)
        telecomSelectView.addArrangedSubview(extraTelecomButton)
        
        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }

        nameTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.bottom).offset(betweenTerms)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(textFieldHeight)
        }
        
        telecomButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextFieldView.snp.bottom).offset(betweenTextFieldViews)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(textFieldHeight)
        }
        
        telecomSelectView.snp.makeConstraints { make in
            make.top.equalTo(telecomButton.snp.bottom).offset(betweenTextFieldViews)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(textFieldHeight * 4)
        }
        
        phoneNumberTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(telecomButton.snp.bottom).offset(betweenTextFieldViews)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(textFieldHeight)
        }
        
        idRequestButton.snp.makeConstraints { make in
            make.centerY.equalTo(phoneNumberTextFieldView.snp.centerY)
            make.trailing.equalTo(phoneNumberTextFieldView.snp.trailing).inset(insidePadding)
        }
        authTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextFieldView.snp.bottom).offset(betweenTextFieldViews)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(textFieldHeight)
        }
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(betweenTerms)
        }
        authNumberCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(authTextFieldView.snp.bottom).offset(insidePadding)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
    }
}
