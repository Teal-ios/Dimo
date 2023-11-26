//
//  SocialLoginEditPasswordView.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/11/26.
//

import UIKit

final class SocialLoginEditPasswordView: BaseView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "비밀번호 변경"
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        return label
    }()
    
    private let socialLoginNotificationLabel: BasePaddingLabel = {
        let label = BasePaddingLabel()
        label.backgroundColor = .black90
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.font = Font.body3
        label.textColor = .black60
        label.text = "소셜로그인으로 가입한 경우 비밀번호를 변경할 수 없어요"
        return label
    }()
    
    override func setupLayout() {
        [titleLabel, socialLoginNotificationLabel].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
        }
        
        socialLoginNotificationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(44)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
}
