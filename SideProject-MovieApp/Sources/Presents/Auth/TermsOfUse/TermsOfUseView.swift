//
//  SignupTermsView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit
import SnapKit

final class TermsOfUseView: BaseView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "이용 약관에 동의해 주세요"
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    
    let allAgreeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let termsOfAgeButton: TermsOfUseButton = {
        let button = TermsOfUseButton(termsTitle: "나이", isHiddenSeeMoreButton: true)
        return button
    }()
    
    private let termsOfUseDIMOButton: TermsOfUseButton = {
        let button = TermsOfUseButton(termsTitle: "DIMO", isHiddenSeeMoreButton: false)
        return button
    }()
    
    private let temrsOfPrivacyButton: TermsOfUseButton = {
        let button = TermsOfUseButton(termsTitle: "개인정보", isHiddenSeeMoreButton: false)
        return button
    }()
    
    private let termsOfPushNotificationButton: TermsOfUseButton = {
        let button = TermsOfUseButton(termsTitle: "푸시 알림", isHiddenSeeMoreButton: true)
        return button
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0.0
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    let acceptButton: OnboardingButton = {
        return OnboardingButton(title: "동의하고 계속하기", ofSize: 14)
    }()
    
    override func setHierarchy() {
        containerStackView.addArrangedSubview(termsOfAgeButton)
        containerStackView.addArrangedSubview(termsOfUseDIMOButton)
        containerStackView.addArrangedSubview(temrsOfPrivacyButton)
        containerStackView.addArrangedSubview(termsOfPushNotificationButton)
        
        self.addSubview(headerLabel)
        self.addSubview(containerStackView)
        self.addSubview(acceptButton)
    }
    
    override func setupLayout() {
        let topLeading: CGFloat = 16
        let buttonHeight: CGFloat = 48
        let buttonBetweenTerms = 24
        let bottom: CGFloat = 36
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(buttonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(bottom)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.bottom.equalTo(acceptButton.snp.top).offset(-buttonBetweenTerms)
        }
    }
}
