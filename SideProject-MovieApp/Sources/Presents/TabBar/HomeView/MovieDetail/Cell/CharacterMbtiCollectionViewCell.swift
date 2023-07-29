//
//  CharacterMbtiCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/25.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterMbtiCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "CharacterMbtiCollectionViewCell"
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.backgroundColor = .black5
        view.clipsToBounds = true
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        label.textAlignment = .center
        label.text = "정대만"
        return label
    }()
    
    let mbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .black60
        label.textAlignment = .center
        label.text = "ENTJ"
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
    }
        
    override func configure() {
        [imgView, nicknameLabel, mbtiLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        imgView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(imgView.snp.width)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(4)
            make.width.equalTo(imgView.snp.width)
            make.height.equalTo(24)
            make.horizontalEdges.equalTo(imgView)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom)
            make.width.equalTo(imgView.snp.width)
            make.height.equalTo(16)
            make.horizontalEdges.equalTo(imgView)
        }
    }
}

extension CharacterMbtiCollectionViewCell {
    func configureUpdateUI(characterData: Characters) {
        self.nicknameLabel.text = characterData.character_name
        self.mbtiLabel.text = characterData.character_mbti ?? "미정"
        let imageURL = URL(string: characterData.character_img ?? "nil")
        if imageURL != URL(string: "nil") {
            self.imgView.kf.setImage(with: imageURL)
        }
    }
}
