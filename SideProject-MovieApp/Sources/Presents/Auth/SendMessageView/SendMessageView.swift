//
//  SendMessageView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/12.
//

import UIKit
import SnapKit

final class SendMessageView: BaseView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "일회용 비밀번호를 보냈어요\n문자를 확인해 주세요."
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    
    let messageImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "message")
        view.contentMode = .scaleAspectFit
        return view
    }()
        
    let returnMessageButton: WordLabelButton = {
        let button = WordLabelButton(text: "일회용 비밀번호 다시 받기")
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let nextButton: OnboardingButton = {
        let button = OnboardingButton(title: "다음", ofSize: 14)
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(nextButton)
        self.addSubview(returnMessageButton)
        self.addSubview(messageImageView)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
            make.height.equalTo(48)
        }
        
        returnMessageButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(16)
        }
        
        messageImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(104)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(72)
            make.height.equalTo(returnMessageButton.snp.width)
        }
    }
}
