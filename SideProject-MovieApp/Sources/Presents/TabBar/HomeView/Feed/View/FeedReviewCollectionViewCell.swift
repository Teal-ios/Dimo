//
//  FeedReviewCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit

final class FeedReviewCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "FeedReviewCollectionViewCell"

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
    
    let nameNameLabel: UILabel = {
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
        label.text = "\(mbti)"
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black5
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "찾아다녀도, 수 황금시대를 웅이한 이상을 끓는 것은 가치를 그리 하였는가? 위하여 아니한 품었기 있는것인가"
        return label
    }()
    
    let likeAndReviewAndInquireLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = Color.caption
        label.textAlignment = .left
        label.text = "좋아요 12 | 댓글 2 | 조회 100"
        return label
    }()
    
    let spoilerContainView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .black80
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    let spoilerWarningImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "warning")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let spoilerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black5
        label.text = "스포일러가 포함된 리뷰입니다."
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
        bgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        [bgView, imgView, nameNameLabel, mbtiLabel, reviewLabel, likeAndReviewAndInquireLabel, spoilerContainView].forEach { self.addSubview($0) }
        spoilerContainView.addArrangedSubview(spoilerWarningImageView)
        spoilerContainView.addArrangedSubview(spoilerLabel)
    }
    
    override func setConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        imgView.snp.makeConstraints { make in
            make.leading.top.equalTo(bgView).inset(16)
            make.height.width.equalTo(48)
        }
        
        nameNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.top)
            make.leading.equalTo(imgView.snp.trailing).offset(8)
            make.trailing.equalTo(bgView.snp.trailing)
            make.height.equalTo(24)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameNameLabel.snp.leading)
            make.top.equalTo(nameNameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(bgView.snp.trailing)
            make.bottom.equalTo(imgView.snp.bottom)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(bgView).inset(16)
            make.top.equalTo(imgView.snp.bottom).offset(16)
            make.height.equalTo(42)
        }
        
        likeAndReviewAndInquireLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(bgView).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(24)
        }
        
        spoilerContainView.snp.makeConstraints { make in
            make.edges.equalTo(reviewLabel)
        }
        
        spoilerWarningImageView.snp.makeConstraints { make in
            make.centerY.equalTo(reviewLabel)
            make.verticalEdges.equalTo(reviewLabel).inset(4)
            make.leading.equalTo(reviewLabel.snp.leading).offset(8)
        }
        
        spoilerLabel.snp.makeConstraints { make in
            make.leading.equalTo(reviewLabel.snp.leading).offset(36)
            make.centerY.equalTo(reviewLabel)
            make.trailing.equalTo(reviewLabel.snp.trailing).offset(-4)
        }
    }
}

extension FeedReviewCollectionViewCell {
    func configureUI(with item: ReviewList) {
        if item.review_spoiler == 1 {
            spoilerContainView.isHidden = false
        } else {
            spoilerContainView.isHidden = true
        }
        nameNameLabel.text = item.nickname
        reviewLabel.text = item.review_content
        mbtiLabel.text = item.mbti
        likeAndReviewAndInquireLabel.text = "좋아요 \(item.review_like)  |  댓글 \(item.comment_count ?? 0)  |  조회 \( item.review_hits)"
    }
}
