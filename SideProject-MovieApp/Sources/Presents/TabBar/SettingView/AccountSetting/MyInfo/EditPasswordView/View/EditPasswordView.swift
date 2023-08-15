//
//  EditPasswordView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import SnapKit

class EditPasswordView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "비밀번호 변경"
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    
    let currentPasswordView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "기존 비밀번호")
    }()
    
    let existingPasswordCheckLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.isHidden = true
        return label
    }()
    
    private lazy var existingPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.addArrangedSubview(currentPasswordView)
        stackView.addArrangedSubview(existingPasswordCheckLabel)
        return stackView
    }()
    
    let newPasswordView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "새로운 비밀번호")
    }()
    
    let passwordValidationCheckLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.text = "숫자, 문자, 특수문자 포함 총 8글자 이상"
        label.textColor = .black60
        return label
    }()
    
    private lazy var newPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.addArrangedSubview(newPasswordView)
        stackView.addArrangedSubview(passwordValidationCheckLabel)
        return stackView
    }()
    
    let newPasswordCheckView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "새로운 비밀번호 재입력")
    }()
    
    private let newPasswordCheckLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        return label
    }()
    
    private lazy var newPasswordCheckStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.addArrangedSubview(newPasswordCheckView)
        stackView.addArrangedSubview(newPasswordCheckLabel)
        return stackView
    }()
    
    let passwordChangeButton: OnboardingButton = {
        let button = OnboardingButton(title: "변경하기", ofSize: 14)
        button.isEnabled = false
        button.configuration?.baseForegroundColor = .white100
        button.configuration?.baseBackgroundColor = .black80
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureTestField()
    }
    
    func configureTestField() {
        currentPasswordView.tf.isSecureTextEntry = true
        newPasswordView.tf.isSecureTextEntry = true
        newPasswordCheckView.tf.isSecureTextEntry = true
    }
    
    override func setupLayout() {
        [titleLabel, existingPasswordStackView, newPasswordStackView, newPasswordCheckStackView, passwordChangeButton].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
        }
        
        existingPasswordStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(44)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        newPasswordStackView.snp.makeConstraints { make in
            make.top.equalTo(existingPasswordStackView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        newPasswordCheckStackView.snp.makeConstraints { make in
            make.top.equalTo(newPasswordStackView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        passwordChangeButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(36)
        }
    }
}

extension EditPasswordView {
    
    func showExistingPasswordTextFieldState(_ isSame: Bool?) {
        guard let isSame = isSame else {
            existingPasswordCheckLabel.isHidden = false
            existingPasswordCheckLabel.text = "기존과 동일한 비밀번호로 변경할 수 없습니다."
            existingPasswordCheckLabel.textColor = UIColor.error
            return
        }
        
        if isSame {
            existingPasswordCheckLabel.isHidden = true
        } else {
            existingPasswordCheckLabel.isHidden = false
            existingPasswordCheckLabel.text = "비밀번호가 일치하지 않습니다."
            existingPasswordCheckLabel.textColor = UIColor.error
        }
    }
    
    func disableChangeButton() {
        passwordChangeButton.isEnabled = false
        passwordChangeButton.setTitleColor(UIColor.white, for: .disabled)
        passwordChangeButton.configuration?.baseBackgroundColor = .black80
    }
    
    func enableChangeButton() {
        passwordChangeButton.isEnabled = true
        passwordChangeButton.configuration?.baseBackgroundColor = .purple100
    }
    
    func showPasswordValidationTextFieldState(_ isValid: Bool = true, isSame: Bool = false) {
        guard isSame == false else {
            passwordValidationCheckLabel.text = "기존과 동일한 비밀번호로 변경할 수 없습니다"
            passwordValidationCheckLabel.textColor = .error
            return
        }
        
        if isValid {
            passwordValidationCheckLabel.text = "숫자, 문자, 특수문자 포함 총 8글자 이상"
            passwordValidationCheckLabel.textColor = .black60
        } else {
            passwordValidationCheckLabel.text = "숫자, 문자, 특수문자 포함 총 8글자 이상"
            passwordValidationCheckLabel.textColor = .error
        }
    }
    
    func showNewPasswordTextFieldState(_ isSame: Bool?) {
        guard let isSame = isSame else { return }
        
        if isSame || newPasswordCheckView.tf.text?.count == 0 {
            newPasswordCheckLabel.isHidden = true
        } else {
            if newPasswordCheckView.tf.text?.count ?? 0 >= 1 {
                newPasswordCheckLabel.isHidden = false
                newPasswordCheckLabel.text = "비밀번호가 일치하지 않습니다."
                newPasswordCheckLabel.textColor = UIColor.error
            }
        }
    }
}
