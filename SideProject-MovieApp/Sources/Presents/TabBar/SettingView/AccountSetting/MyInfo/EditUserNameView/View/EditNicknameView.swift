//
//  EditUserNameView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit

class EditNicknameView: BaseView {
    
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
        label.text = "한달에 한번만 변경할 수 있어요"
        return label
    }()
    
    let idTextFieldView: OnboardingTextFieldView = {
        return OnboardingTextFieldView()
    }()
    
    let duplicationCheckButton: OnboardingButton = {
        let button = OnboardingButton(title: "중복확인")
        button.configuration?.baseBackgroundColor = .black100
        button.configuration?.baseForegroundColor = .black80
        return button
    }()
    
    let policyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = .suitFont(ofSize: 12)
        label.text = "마지막 변경일 : 2023.05.25"
        return label
    }()
    
    let nextButton: OnboardingButton = {
        let button = OnboardingButton(title: "변경하기", ofSize: 14)
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
        [titleLabel, explainLabel, idTextFieldView, nextButton, policyLabel].forEach { self.addSubview($0) }
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
            make.centerY.equalTo(idTextFieldView.snp.centerY)
            make.trailing.equalTo(idTextFieldView.snp.trailing).inset(insidePadding)
        }
        policyLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(insidePadding)
            make.leading.equalTo(idTextFieldView.snp.leading)
        }
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(betweenTerms)
        }
    }
}
