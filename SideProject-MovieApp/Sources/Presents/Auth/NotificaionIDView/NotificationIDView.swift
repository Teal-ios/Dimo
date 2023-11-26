//
//  NotificationView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import UIKit
import SnapKit

final class NotificationIDView: BaseView {
    
    let notificationIDLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "아이디를 가져오는데 실패했습니다/n 다시 시도해주시기 바랍니다."
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
        
    let passwordFindButton: WordLabelButton = {
        let button = WordLabelButton(text: "비밀번호 찾기")
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let nextButton: OnboardingButton = {
        let button = OnboardingButton(title: "다음", ofSize: 14)
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(notificationIDLabel)
        self.addSubview(nextButton)
        self.addSubview(passwordFindButton)
    }
    
    override func setupLayout() {
        notificationIDLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
            make.height.equalTo(48)
        }
        
        passwordFindButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(16)
        }
    }
    
}

extension NotificationIDView {
    
    func setNotificationIDLabelText(userName: String, userId: String) {
        notificationIDLabel.text = "\(userName)님의 아이디는\n \(userId) 입니다."
    }
}
