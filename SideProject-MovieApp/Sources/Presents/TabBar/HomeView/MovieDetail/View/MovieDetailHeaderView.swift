//
//  MovieDetailHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/25.
//

import UIKit
import SnapKit

class MovieDetailHeaderView: UICollectionReusableView {
    static let identifier = "MovieDetailHeaderView"
    
    let detailHeaderView : DetailHeaderView = {
        let view = DetailHeaderView(title: "스즈메의 문단속", subTitle: "애니메이션 | 124분")
        return view
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "LikeNonSelect"), for: .normal)
        return button
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.caption
        label.textAlignment = .center
        label.text = "좋아요"
        return label
    }()
    
    let evaluateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_rating_off_clear"), for: .normal)
        return button
    }()
    
    let evaluateLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .black60
        label.textAlignment = .center
        label.text = "평가하기"
        return label
    }()
    
    let evaluateNumberLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .black60
        label.textAlignment = .center
        label.text = "5.0"
        return label
    }()
    
    let summarytitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.text = "줄거리"
        return label
    }()
    
    let summaryExplainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.numberOfLines = 0
        label.text = "전국 제패를 꿈꾸는 북산고 농구부 5인방의 꿈과 열정, 멈추지 않는 도전을 그린 영화"
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textColor = .black5
        label.text = "등장인물"
       return label
    }()
    
    let moreButton: WordLabelButton = {
        let button = WordLabelButton(text: "더보기 >")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(detailHeaderView)
        self.addSubview(likeButton)
        self.addSubview(likeLabel)
        self.addSubview(evaluateButton)
        self.addSubview(evaluateLabel)
        self.addSubview(evaluateNumberLabel)
        self.addSubview(summarytitleLabel)
        self.addSubview(summaryExplainLabel)
        self.addSubview(titleLabel)
        self.addSubview(moreButton)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        detailHeaderView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(280)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(detailHeaderView.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(28)
            make.width.height.equalTo(24)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(4)
            make.centerX.equalTo(likeButton)
            make.height.equalTo(16)
            make.width.equalTo(48)
        }
        
        evaluateButton.snp.makeConstraints { make in
            make.top.equalTo(detailHeaderView.snp.bottom).offset(16)
            make.leading.equalTo(likeLabel.snp.trailing).offset(20)
            make.width.height.equalTo(24)
        }
        
        evaluateLabel.snp.makeConstraints { make in
            make.top.equalTo(evaluateButton.snp.bottom).offset(4)
            make.centerX.equalTo(evaluateButton)
            make.height.equalTo(16)
            make.width.equalTo(48)
        }
        
        evaluateNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(evaluateLabel.snp.bottom)
            make.horizontalEdges.equalTo(evaluateLabel.snp.horizontalEdges)
            make.height.equalTo(16)
        }
        
        summarytitleLabel.snp.makeConstraints { make in
            make.top.equalTo(likeLabel.snp.bottom).offset(36)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        
        summaryExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(summarytitleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(summaryExplainLabel.snp.bottom).offset(16)
            make.height.equalTo(19)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.equalTo(16)
        }
    }
}
