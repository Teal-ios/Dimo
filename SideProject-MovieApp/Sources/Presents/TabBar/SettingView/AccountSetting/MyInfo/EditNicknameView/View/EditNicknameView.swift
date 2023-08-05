//
//  EditUserNameView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit

final class EditNicknameView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black60
        label.text = "한 달에 한번만 변경할 수 있어요"
        return label
    }()
    
    let idTextFieldView: OnboardingTextFieldView = {
        return OnboardingTextFieldView()
    }()
    
    let duplicationCheckButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.titleLabel?.font = .suitFont(ofSize: 12, weight: .Medium)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .black100
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let policyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = .suitFont(ofSize: 12)
        label.text = "마지막 변경일 : 2023.05.25"
        return label
    }()
    
    let nicknameChangeButton: OnboardingButton = {
        let button = OnboardingButton(title: "변경하기", ofSize: 14)
        button.isEnabled = false
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
        [titleLabel, explainLabel, idTextFieldView, nicknameChangeButton, policyLabel].forEach { self.addSubview($0) }
        idTextFieldView.addSubview(duplicationCheckButton)
        
        let topLeading: CGFloat = 16
        let betweenTerms: CGFloat = 36
        let insidePadding: CGFloat = 8
        let buttonHeight = 48
        let textFieldHeight = 52
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(topLeading)
            make.leading.equalTo(safeAreaLayoutGuide).offset(topLeading)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(18)
        }
        idTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(betweenTerms)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.height.equalTo(textFieldHeight)
        }
        duplicationCheckButton.snp.makeConstraints { make in
            make.width.equalTo(72.0)
            make.height.equalTo(36.0)
            make.centerY.equalTo(idTextFieldView.snp.centerY)
            make.trailing.equalTo(idTextFieldView.snp.trailing).inset(insidePadding)
        }
        policyLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(insidePadding)
            make.leading.equalTo(idTextFieldView.snp.leading)
        }
        nicknameChangeButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(betweenTerms)
        }
    }
}

extension EditNicknameView {
    
    func enableDuplicationCheckButton(isEnabled: Bool) {
        if isEnabled {
            duplicationCheckButton.isEnabled = true
            duplicationCheckButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            duplicationCheckButton.isEnabled = false
            duplicationCheckButton.setTitleColor(UIColor.black80, for: .disabled)
        }
    }
    
    func checkNicknameChangeButton(isValid: Bool) {
        if isValid {
            nicknameChangeButton.isEnabled = true
            nicknameChangeButton.configuration?.baseBackgroundColor = .purple100
        } else {
            nicknameChangeButton.isEnabled = false
            nicknameChangeButton.configuration?.baseBackgroundColor = .black80
        }
    }
}

extension EditNicknameView {
    
    func showCurrentNickname() {
        let currentNickname = UserDefaults.standard.string(forKey: "userId")
        idTextFieldView.tf.text = currentNickname ?? ""
    }
}

// MARK: - Policy Label Text
extension EditNicknameView {
    
    func showLastNicknameChangedDate() {
        policyLabel.text = "마지막 변경일 : 2023.05.25"
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
}
