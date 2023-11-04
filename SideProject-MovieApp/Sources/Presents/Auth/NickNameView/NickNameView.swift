//
//  NicknameView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/03.
//

import UIKit
import SnapKit

class NicknameView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    
    let idTextFieldView: OnboardingTextFieldView = {
        return OnboardingTextFieldView()
    }()
    
    let policyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .suitFont(ofSize: 12)
        return label
    }()
    
    let nextButton: OnboardingButton = {
        let button = OnboardingButton(title: "다음", ofSize: 14)
        button.configuration?.baseBackgroundColor = .black80
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String?, placeholder: String?) {
        self.init()
        titleLabel.text = title
        idTextFieldView.tf.placeholder = placeholder
    }
    
    override func setupLayout() {
        [titleLabel, idTextFieldView, nextButton, policyLabel].forEach { self.addSubview($0) }

        let topLeading: CGFloat = 16
        let betweenTerms: CGFloat = 36
        let insidePadding: CGFloat = 8
        let buttonHeight = 48
        let textFieldHeight = 52
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        
        idTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(betweenTerms)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(textFieldHeight)
        }
        
        policyLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(insidePadding)
            make.leading.equalTo(idTextFieldView.snp.leading).offset(0)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(betweenTerms)
        }
    }
}

extension NicknameView {
    
    func checkNextButton(isValid: Bool) {
        if isValid {
            nextButton.isEnabled = true
            nextButton.configuration?.baseBackgroundColor = .purple100
        } else {
            nextButton.isEnabled = false
            nextButton.configuration?.baseBackgroundColor = .black80
        }
    }
    
    func showLastNicknameChangeDate(date: String) {
        policyLabel.text = "마지막 변경일 : \(date)"
        policyLabel.textColor = .black60
    }
    
    func showEmptyMessage() {
        policyLabel.text = ""
        policyLabel.textColor = .black60
    }
    
    func showUnvalidNicknameFormatMessage() {
        policyLabel.text = "두 글자 이상 입력해주세요."
        policyLabel.textColor = Color.error
    }
    
    func showDuplicatedNicknameMessage() {
        policyLabel.text = "중복된 닉네임이 존재합니다."
        policyLabel.textColor = Color.error
    }
    
    func showValidNicknameMessage() {
        policyLabel.text = "사용 가능한 닉네임입니다."
        policyLabel.textColor = .black60
    }
    
    func showViewIfNotOverOneMonth() {
        nextButton.isHidden = true
        idTextFieldView.tf.isEnabled = false
        idTextFieldView.tf.textColor = .black80
    }
}
