//
//  DimoLoginView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/12.
//

import UIKit
import SnapKit

class DimoLoginView: BasicLoginView {
    
    let passwordView: OnboardingTextFieldView = {
        return OnboardingTextFieldView(placeholder: "비밀번호")
    }()
    
    let passwordFindButton: WordLabelButton = {
        let label = WordLabelButton(text: "비밀번호 찾기")
        return label
    }()
    
    let idFindButton: WordLabelButton = {
        let label = WordLabelButton(text: "아이디 찾기")
        return label
    }()
    
    let firstDimoButton: WordLabelButton = {
        let label = WordLabelButton(text: "DIMO가 처음이신가요?")
        label.contentHorizontalAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let top: CGFloat = 48
        let leadingTrailing: CGFloat = 16
        self.addSubview(idFindButton)
        self.addSubview(passwordView)
        self.addSubview(passwordFindButton)
        self.addSubview(firstDimoButton)
        
        idFindButton.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).inset(8)
            make.width.equalTo(80)
            make.height.equalTo(16)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(52)
        }
        
        passwordFindButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).inset(8)
            make.width.equalTo(100)
            make.height.equalTo(16)
        }
        
        firstDimoButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(16)
        }
        
        
        passwordView.tf.isSecureTextEntry = true
        duplicateCheckButton.isEnabled = false
        duplicateCheckButton.isHidden = true
    }
}
