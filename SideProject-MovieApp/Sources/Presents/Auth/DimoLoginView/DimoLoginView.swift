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
    
    let passwordFindLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = UIColor(red: 168/255, green: 168/255, blue: 167/255, alpha: 1)
        label.text = "비밀번호 찾기"
        return label
    }()
    
    let idFindLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.text = "아이디 찾기"
        label.textColor = UIColor(red: 168/255, green: 168/255, blue: 167/255, alpha: 1)
        return label
    }()
    
    let firstDimoLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.text = "DIMO가 처음이신가요?"
        label.textColor = UIColor(red: 168/255, green: 168/255, blue: 167/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let top: CGFloat = 48
        let leadingTrailing: CGFloat = 16
        self.addSubview(idFindLabel)
        self.addSubview(passwordView)
        self.addSubview(passwordFindLabel)
        self.addSubview(firstDimoLabel)
        
        idFindLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(16)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.bottom).offset(top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(52)
        }
        
        passwordFindLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(leadingTrailing)
            make.height.equalTo(16)
        }
        
        firstDimoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(16)
        }
        
        
        passwordView.tf.isSecureTextEntry = true
        duplicateCheckButton.isEnabled = false
        duplicateCheckButton.isHidden = true
    }
    
}
