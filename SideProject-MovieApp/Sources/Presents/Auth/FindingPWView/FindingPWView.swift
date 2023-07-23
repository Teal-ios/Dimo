//
//  FindingPWView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import UIKit
import SnapKit

final class FindPWView: BaseView {
    let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 찾기"
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    let idTextFieldView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "아이디")
    }()
    
    let nameTextFieldView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "이름")
    }()
    
    let telecomButton: TelecomButton = {
        return TelecomButton(title: "통신사", foregroundColor: .black60)
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
    
    let nextButton: OnboardingButton = {
        return OnboardingButton(title: "다음", ofSize: 14)
    }()
    let validLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .error
        label.text = "존재하지 않는 사용자 정보입니다."
        return label
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
         idTextFieldView,
         nameTextFieldView,
         telecomButton,
         phoneNumberTextFieldView,
         authNumberCheckLabel,
         telecomSelectView,
         validLabel,
         nextButton]
            .forEach { self.addSubview($0) }
        
        telecomSelectView.addArrangedSubview(sktButton)
        telecomSelectView.addArrangedSubview(ktButton)
        telecomSelectView.addArrangedSubview(uplusButton)
        telecomSelectView.addArrangedSubview(extraTelecomButton)
        
        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }

        idTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.bottom).offset(betweenTerms)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(textFieldHeight)
        }
        
        nameTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(betweenTextFieldViews)
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
        
        validLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextFieldView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(16)
        }

        nextButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(betweenTerms)
        }
    }
}
