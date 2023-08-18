//
//  VoteCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit
import SnapKit

class VoteCollectionViewCell: BaseCollectionViewCell {
    static let voteCollectionViewIdentifier = "VoteCollectionViewCell"

    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = Font.body2
        view.text = "정대만"
        return view
    }()
    
    let movieTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Font.caption
        view.textColor = Color.caption
        view.text = "더퍼스트슬램덩크"

        return view
    }()

    let imgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .label
        view.image = UIImage(systemName: "person.fill")
        view.clipsToBounds = true
        return view
    }()
    
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.clipsToBounds = true
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    let checkImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Check")
        view.tintColor = .black5
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.bounds.height / 2
        blurView.layer.cornerRadius = blurView.frame.width / 2
    }
        
    override func configure() {
        addSubview(imgView)
        addSubview(nameLabel)
        addSubview(movieTitleLabel)
        addSubview(blurView)
        addSubview(checkImageView)
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.equalToSuperview()
            make.width.equalTo(imgView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(8)
            make.top.equalTo(imgView.snp.top).offset(4)
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(imgView)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(imgView)
            make.width.height.equalTo(32)
        }
    }
}

extension VoteCollectionViewCell {
    func configureAttribute(with item: AnimationData) {
//        let imageUrl = URL(string: item.poster)
//        imgView.kf.setImage(with: imageUrl)
//        imgView.contentMode = .scaleToFill
//        movieTitleLabel.text = item.title
//        nameLabel.text = item.characters[0].characterName
    }
}

extension VoteCollectionViewCell {
    func configureAttributeWithCharacterInfo(with item: CharacterInfo) {
        let imageUrl = URL(string: item.character_img)
        imgView.kf.setImage(with: imageUrl)
        imgView.contentMode = .scaleToFill
        nameLabel.text = item.character_name
        movieTitleLabel.text = item.title ?? "미제공"
    }
}

extension VoteCollectionViewCell {
    func configureIsVoted(vote: Int) {
        if vote == 1 {
            self.blurView.isHidden = false
            self.checkImageView.isHidden = false
        } else {
            self.blurView.isHidden = true
            self.checkImageView.isHidden = true
        }
    }
}
