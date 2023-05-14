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
        view.backgroundColor = .white100
        view.clipsToBounds = true
        return view
    }()
    
    let nameNameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .white100
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
        label.textColor = .white100
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
        bgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        [bgView, imgView, nameNameLabel, mbtiLabel, reviewLabel, likeAndReviewAndInquireLabel].forEach { self.addSubview($0) }
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
    }
}
