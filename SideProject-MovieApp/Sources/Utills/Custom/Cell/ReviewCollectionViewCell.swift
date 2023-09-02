//
//  ReviewCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit
import Kingfisher

class ReviewCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "ReviewCollectionViewCell"

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
        let mbti = UserDefaultManager.mbti ?? "ISFJ"
        label.text = mbti
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black5
        label.textAlignment = .left
        label.text = "슬램덩크속 정대만 캐릭터의 솔직 리뷰"
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .left
        label.text = "더퍼스트슬램덩크"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
        bgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        [bgView, imgView, characterNameLabel, mbtiLabel, reviewLabel, titleLabel].forEach { self.addSubview($0) }
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
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(bgView).inset(16)
            make.top.equalTo(reviewLabel.snp.bottom).offset(8)
            make.height.equalTo(24)
        }
    }
}

extension ReviewCollectionViewCell {
    func configureUpdateReviewDate(review: MyReview) {
        reviewLabel.text = review.review_content
        characterNameLabel.text = review.character_name
        mbtiLabel.text = review.character_mbti ?? "미정"
        titleLabel.text = review.title
        let imageURL = URL(string: review.character_img)
        imgView.kf.setImage(with: imageURL)
    }
}

extension ReviewCollectionViewCell {
    func configureUpdateCommentDate(comment: MyComment) {
        let imageURL = URL(string: comment.character_img)
        reviewLabel.text = comment.comment_content
        characterNameLabel.text = comment.character_name
        mbtiLabel.text = comment.character_mbti ?? "미정"
        titleLabel.text = comment.title
        imgView.kf.setImage(with: imageURL)
    }
}
