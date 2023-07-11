//
//  EditPasswordView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import SnapKit

class EditPasswordView: IDRegisterView {
    
    let existingPasswordView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "기존 비밀번호")
    }()
    
    let newPasswordView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "새로운 비밀번호")
    }()
    
    let newPasswordkCheckView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "새로운 비밀번호 재입력")
    }()
    
    let passwordValidationCheckLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.text = "숫자, 문자, 특수문자 포함 총 8글자 이상"
        label.textColor = UIColor(red: 168/255, green: 168/255, blue: 167/255, alpha: 1)
        return label
    }()
    
    let passwordConditionLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        return label
    }()
    
    let newPasswordCheckView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "새로운 비밀번호 재입력")
    }()
    
    let newPasswordCheckLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let top: CGFloat = 48
        let leadingTrailing: CGFloat = 16
        self.addSubview(passwordConditionLabel)
        self.addSubview(newPasswordView)
        self.addSubview(passwordValidationCheckLabel)
        self.addSubview(newPasswordCheckView)
        self.addSubview(newPasswordCheckLabel)
        
        passwordConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(16)
        }
        
        newPasswordView.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(52)
        }
        
        passwordValidationCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(16)
        }
        
        newPasswordCheckView.snp.makeConstraints { make in
            make.top.equalTo(newPasswordView.snp.bottom).offset(top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(52)
        }
        
        newPasswordCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordCheckView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(16)
        }
        
        newPasswordView.tf.isSecureTextEntry = true
        idTextFieldView.tf.isSecureTextEntry = true
        newPasswordCheckView.tf.isSecureTextEntry = true
        
        duplicateCheckButton.isEnabled = false
        duplicateCheckButton.isHidden = true
    }
}

extension EditPasswordView {
    
    func disableChangeButton() {
        nextButton.isEnabled = false
        nextButton.setTitleColor(UIColor.white, for: .disabled)
        nextButton.configuration?.baseBackgroundColor = .black80
    }
}
