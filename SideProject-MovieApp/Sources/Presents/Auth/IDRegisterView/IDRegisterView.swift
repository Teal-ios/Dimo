//
//  IDRegisterView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/30.
//

import UIKit
import SnapKit

class IDRegisterView: BaseView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    let idTextFieldView: OnboardingTextFieldView = {
        return OnboardingTextFieldView()
    }()
    let duplicateCheckButton: OnboardingButton = {
        let button = OnboardingButton(title: "중복확인")
        button.configuration?.baseBackgroundColor = .black100
        button.configuration?.baseForegroundColor = .black80
        return button
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
        idTextFieldView.addSubview(duplicateCheckButton)
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
        duplicateCheckButton.snp.makeConstraints { make in
            make.centerY.equalTo(idTextFieldView.snp.centerY)
            make.trailing.equalTo(idTextFieldView.snp.trailing).inset(insidePadding)
        }
        policyLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(insidePadding)
            make.leading.equalTo(idTextFieldView.snp.leading).offset(topLeading)
        }
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(topLeading)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(betweenTerms)
        }
    }
    
}
