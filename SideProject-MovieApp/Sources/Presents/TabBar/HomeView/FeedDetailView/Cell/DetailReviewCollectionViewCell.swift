//
//  DetailReviewCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/15.
//

import UIKit
import SnapKit

class DetailReviewCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "DetailReviewCollectionViewCell"

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        return view
    }()
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.backgroundColor = .black5
        view.clipsToBounds = true
        return view
    }()
    
    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        label.textAlignment = .left
        label.text = "정대만"
        return label
    }()
    
    let mbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .left
        label.text = "ISFJ"
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black5
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "불러 계절이 하나에 하나에 까닭입니다. 멀리 시인의 이름자를 소학교 마리아 추억과 슬퍼하는 하늘에는 버리었습니다."
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "LikeSelect"), for: .normal)
        return button
    }()
    
    let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .left
        label.text = "0"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
        bgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        [bgView, imgView, characterNameLabel, mbtiLabel, reviewLabel, likeButton, likeCountLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        imgView.snp.makeConstraints { make in
            make.leading.top.equalTo(bgView).inset(16)
            make.height.width.equalTo(48)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.top)
            make.leading.equalTo(imgView.snp.trailing).offset(8)
            make.trailing.equalTo(bgView.snp.trailing)
            make.height.equalTo(24)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterNameLabel.snp.leading)
            make.top.equalTo(characterNameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(bgView.snp.trailing)
            make.bottom.equalTo(imgView.snp.bottom)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(bgView).inset(16)
            make.top.equalTo(imgView.snp.bottom).offset(16)
            make.bottom.equalTo(likeButton.snp.top)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(bgView).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.width.equalTo(16)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(4)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(16)
        }
    }
}

extension DetailReviewCollectionViewCell {
    func configureCommentAttribute(with item: CommentList) {
        reviewLabel.text = item.comment_content
        characterNameLabel.text = item.user_id
        if item.is_liked == nil {
            self.updateLikeImage(is_like: false)
        } else {
            self.updateLikeImage(is_like: true)
        }
    }
}

extension DetailReviewCollectionViewCell {
    func updateLikeImage(is_like: Bool) {
        switch is_like {
        case true:
            self.likeButton.setImage(UIImage(named: "LikeSelect"), for: .normal)
        case false:
            self.likeButton.setImage(UIImage(named: "LikeNonSelect"), for: .normal)
        }
    }
}
