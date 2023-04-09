//
//  PasswordView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/04/02.
//

import UIKit
import SnapKit

class PasswordView: IDRegisterView {
    let passwordCheckView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "비밀번호 재입력")
    }()
    
    let passwordCheckLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        return label
    }()
    
    let passwordConditionLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.text = "숫자, 문자, 특수문자 포함 총 8글자 이상"
        label.textColor = UIColor(red: 168/255, green: 168/255, blue: 167/255, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let top: CGFloat = 48
        let leadingTrailing: CGFloat = 16
        self.addSubview(passwordConditionLabel)
        self.addSubview(passwordCheckView)
        self.addSubview(passwordCheckLabel)
        
        passwordConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(16)
        }
        
        passwordCheckView.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(52)
        }
        
        passwordCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordCheckView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(16)
        }
        
        passwordCheckView.tf.isSecureTextEntry = true
        idTextFieldView.tf.isSecureTextEntry = true
        duplicateCheckButton.isEnabled = false
        duplicateCheckButton.isHidden = true
    }
    
}
