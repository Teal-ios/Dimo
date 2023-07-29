//
//  ProfileView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .suitFont(ofSize: 24, weight: .Bold)
        label.textAlignment = .left
        label.text = "My Momentum"
        return label
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.clipsToBounds = true
        return view
    }()
    
    let profileSettingButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "ProfileSetting"), for: .normal)
        return button
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle2
        label.textColor = .black5
        label.textAlignment = .center
        label.text = "나는문어"
       return label
    }()
    
    let mbtiLabel: UILabel = {
       let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .center
        label.text = "ISFJ"
        return label
    }()
    
    let introduceView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black90
        return view
    }()
    
    let introduceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        introduceView.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [titleLabel, profileImageView, profileSettingButton, nicknameLabel, mbtiLabel, introduceView, introduceLabel ].forEach { self.addSubview($0) }
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let leading = 16.0
        let safeArea = self.safeAreaLayoutGuide

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeArea).offset(leading)
            make.top.equalTo(safeArea)
            make.height.equalTo(32)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.width.equalTo(109)
            make.height.equalTo(109)
        }
        
        profileSettingButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeArea)
            make.height.equalTo(24)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeArea)
            make.height.equalTo(20)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(safeArea).inset(32)
            make.height.greaterThanOrEqualTo(20)
        }
        
        introduceView.snp.makeConstraints { make in
            make.edges.equalTo(introduceLabel).inset(-16)
        }
    }
}

extension ProfileView {
    func configureProfileUpdate(profile: MyProfile) {
        self.nicknameLabel.text = profile.nickname
        self.mbtiLabel.text = profile.mbti
        if profile.intro == nil {
            self.introduceLabel.text = "자기소개를 추가해 보세요."
            self.introduceLabel.textColor = .black60
        } else {
            self.introduceLabel.text = profile.intro
        }
        
        let imageURL = URL(string: profile.profile_img ?? "nil")
        if imageURL != URL(string: "nil") {
            self.profileImageView.kf.setImage(with: imageURL)
        }
    }
}
