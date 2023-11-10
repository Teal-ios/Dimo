//
//  OtherProfileView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/17.
//

import UIKit
import SnapKit
import Kingfisher

class OtherProfileView: BaseView {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.clipsToBounds = true
        return view
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
        let mbti = UserDefaultManager.mbti ?? "ISFJ"
        label.text = mbti
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
        [profileImageView, nicknameLabel, mbtiLabel, introduceView, introduceLabel ].forEach { self.addSubview($0) }
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        let leading = 16.0
        let safeArea = self.safeAreaLayoutGuide

        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.top.equalTo(safeArea).offset(36)
            make.width.equalTo(109)
            make.height.equalTo(109)
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

extension OtherProfileView {
    func configureProfileUpdate(profile: MyProfile) {
        self.nicknameLabel.text = profile.nickname
        self.mbtiLabel.text = profile.mbti
        if profile.intro == nil {
            self.introduceLabel.isHidden = true
            self.introduceView.isHidden = true
            introduceLabel.snp.removeConstraints()
            introduceView.snp.removeConstraints()
        } else {
            self.introduceLabel.text = profile.intro
        }
        
//        let imageURL = URL(string: profile.profile_img ?? "nil")
//        if imageURL != URL(string: "nil") {
//            self.profileImageView.kf.setImage(with: imageURL)
//        }
        
        guard let profileImgPath = profile.profile_img else { return }
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // 이미지 파일의 전체 경로 생성
            let imagePath = documentsDirectory.appendingPathComponent(profileImgPath)
            
            // 이미지 파일이 존재하는지 확인
            if FileManager.default.fileExists(atPath: imagePath.path) {
                
                // UIImage 생성
                if let image = UIImage(contentsOfFile: imagePath.path) {
                    // 이제 'image'를 사용하여 프로필 이미지를 표시하면 됩니다.
                    // 예를 들어, 이미지 뷰에 설정할  수 있습니다.
                    // imageView.image = image
                    self.profileImageView.image = image
                } else {
                    print("이미지를 불러올 수 없습니다.")
                }
                
            } else {
                print("이미지 파일이 존재하지 않습니다.")
            }
        }
    }
}
