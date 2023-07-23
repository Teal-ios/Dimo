//
//  JoinCompleteView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import UIKit
import SnapKit

final class JoinCompleteView: BaseView {
    let finishSignUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.title1
        label.text = "회원가입을 완료했어요"
        return label
    }()
    
    let finishImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        return view
    }()
    
    let dimoStartButton: OnboardingButton = {
        let button = OnboardingButton(title: "DIMO 시작하기", ofSize: 14)
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(finishSignUpLabel)
        self.addSubview(dimoStartButton)
        self.addSubview(finishImageView)

    }
    
    override func setupLayout() {
        finishSignUpLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(72)
            make.height.equalTo(29)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        dimoStartButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
            make.height.equalTo(48)
        }
        
        finishImageView.snp.makeConstraints { make in
            make.top.equalTo(finishSignUpLabel.snp.bottom).offset(104)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(72)
            make.height.equalTo(finishImageView.snp.width)
        }
    }
}
