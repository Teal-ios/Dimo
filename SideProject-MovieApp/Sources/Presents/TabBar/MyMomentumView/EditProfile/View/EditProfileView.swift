//
//  EditProfileView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import UIKit
import SnapKit

final class EditProfileView: BaseView {
    
    let bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.textAlignment = .left
        label.text = "프로필 수정"
        return label
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageEditButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "camera"), for: .normal)
        return button
    }()
    
    let introduceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textAlignment = .left
        label.text = "자기소개"
        return label
    }()
    
    let introduceEditContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        return view
    }()
    
    let introduceEditTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .black90
        view.text = "자기소개를 입력해 보세요"
        view.textColor = .black60
        return view
    }()
    
    let okButton: OnboardingButton = {
        let button = OnboardingButton(title: "확인")
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(titleLabel)
        self.addSubview(profileImageView)
        self.addSubview(profileImageEditButton)
        self.addSubview(introduceLabel)
        self.addSubview(introduceEditContainView)
        self.addSubview(introduceEditTextView)
        self.addSubview(okButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        introduceEditContainView.layer.cornerRadius = 8
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
        
    
    override func setupLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.height.equalTo(32)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.width.equalTo(109)
            make.height.equalTo(109)
        }
        
        profileImageEditButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(36)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(18)
        }
        
        introduceEditContainView.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(104)
        }
        
        introduceEditTextView.snp.makeConstraints { make in
            make.edges.equalTo(introduceEditContainView).inset(16)
        }
        
        okButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(36)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
    }
}

extension EditProfileView {
    func updateIntroduceTextView() {
        let textViewPlaceHolder = "자기소개를 입력해 보세요"

        if introduceEditTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            introduceEditTextView.text = textViewPlaceHolder
            introduceEditTextView.textColor = .black80
        }
    }
    
    func updateIntroduceTextViewTextNil() {
        introduceEditTextView.text = nil
        introduceEditTextView.textColor = .black5
    }
}

extension EditProfileView {
    func updateProfileImage(image: UIImage) {
        self.profileImageView.contentMode = .scaleToFill
        let resizeImage = image.resizeImageTo(size: CGSize(width: self.profileImageView.frame.width, height: self.profileImageView.frame.height))
        self.profileImageView.image = resizeImage
    }
}
