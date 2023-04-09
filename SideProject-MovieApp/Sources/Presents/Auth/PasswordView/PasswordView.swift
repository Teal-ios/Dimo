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
    override init(frame: CGRect) {
        super.init(frame: frame)
        let top: CGFloat = 48
        let leadingTrailing: CGFloat = 16
        self.addSubview(passwordCheckView)
        passwordCheckView.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(52)
        }
        passwordCheckView.tf.isSecureTextEntry = true
        idTextFieldView.tf.isSecureTextEntry = true
        duplicateCheckButton.isEnabled = false
        duplicateCheckButton.isHidden = true
    }
    
}
