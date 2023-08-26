//
//  EditNotificationView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/04.
//

import UIKit

final class PushNotificationSettingView: BaseView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.text = "푸시 알림"
        return label
    }()
    
    private let allNotificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.text = "모든 푸시 알림"
        label.font = Font.body2
        return label
    }()
    
    let allNotificationSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.backgroundColor = .black60
        switchView.tintColor = .black60
        switchView.onTintColor = .purple100
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        return view
    }()
    
    private let replyNotificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.text = "댓글 알림"
        label.font = Font.body2
        return label
    }()
    
    let replyNotificationSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.backgroundColor = .black60
        switchView.tintColor = .black60
        switchView.onTintColor = .purple100
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    private let keywordNotificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.text = "키워드 알림"
        label.font = Font.body2
        return label
    }()
    
    let keywordNotificationSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.backgroundColor = .black60
        switchView.tintColor = .black60
        switchView.onTintColor = .purple100
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    private let dimoNewsNotificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.text = "DIMO 소식 알림"
        label.font = Font.body2
        return label
    }()
    
    let dimoNewsNotificationSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.backgroundColor = .black60
        switchView.tintColor = .black60
        switchView.onTintColor = .purple100
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    override func setHierarchy() {
        self.addSubview(headerLabel)
        self.addSubview(allNotificationLabel)
        self.addSubview(allNotificationSwitch)
        self.addSubview(borderView)
        self.addSubview(replyNotificationLabel)
        self.addSubview(replyNotificationSwitch)
        self.addSubview(keywordNotificationLabel)
        self.addSubview(keywordNotificationSwitch)
        self.addSubview(dimoNewsNotificationLabel)
        self.addSubview(dimoNewsNotificationSwitch)
    }
    
    override func setupLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(16)
            make.height.equalTo(44)
        }
        
        allNotificationLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.leading)
            make.top.equalTo(headerLabel.snp.bottom).offset(36)
            make.height.equalTo(52)
        }
        
        allNotificationSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.centerY.equalTo(allNotificationLabel.snp.centerY)
        }
        
        borderView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.top.equalTo(allNotificationLabel.snp.bottom).offset(24)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(1)
        }
        
        replyNotificationLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.leading)
            make.top.equalTo(borderView.snp.bottom).offset(24)
            make.height.equalTo(52)
        }
        
        replyNotificationSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(allNotificationSwitch.snp.trailing)
            make.centerY.equalTo(replyNotificationLabel.snp.centerY)
        }
        
        keywordNotificationLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.leading)
            make.top.equalTo(replyNotificationLabel.snp.bottom)
            make.height.equalTo(52)
        }
        
        keywordNotificationSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(allNotificationSwitch.snp.trailing)
            make.centerY.equalTo(keywordNotificationLabel.snp.centerY)
        }
        
        dimoNewsNotificationLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.leading)
            make.top.equalTo(keywordNotificationLabel.snp.bottom)
            make.height.equalTo(52)
        }
        
        dimoNewsNotificationSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(allNotificationSwitch.snp.trailing)
            make.centerY.equalTo(dimoNewsNotificationLabel.snp.centerY)
        }
    }
}

extension PushNotificationSettingView {
    
    func didTappedAllNotificaionSwitch(_ isOn: Bool) {
        replyNotificationSwitch.isOn = isOn
        keywordNotificationSwitch.isOn = isOn
        dimoNewsNotificationSwitch.isOn = isOn
    }
    
    func didTappedReplyNotificationSwitch(_ isOn: Bool) {
        if isOn == false {
            allNotificationSwitch.isOn = isOn
        }
    }
    
    func didTappedKeywordNotificationSwitch(_ isOn: Bool) {
        if isOn == false {
            allNotificationSwitch.isOn = isOn
        }
    }
    
    func didTappedDimoNewsNotificationSwitch(_ isOn: Bool) {
        if isOn == false {
            allNotificationSwitch.isOn = isOn
        }
    }
    
    func turnOnAllNotificationSwitch() {
        allNotificationSwitch.isOn = true
    }
}
