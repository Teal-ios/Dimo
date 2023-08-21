//
//  MovieDetailHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/25.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailHeaderView: BaseView {
    
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
        label.text = "찜하기"
        return label
    }()
    
    let evaluateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Good_Nonselect"), for: .normal)
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
        label.text = ""
        return label
    }()
    
    lazy var mbtiInfoStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .vertical
        view.spacing = 16
        view.addArrangedSubview(firstMbtiView)
        view.addArrangedSubview(secondMbtiView)
        view.addArrangedSubview(thirdMbtiView)
        return view
    }()
    
    let firstMbtiView: MbtiInfoView = {
        let view = MbtiInfoView(mbti: "ESTJ", explainText: "가 가장 많이 찜했어요", image: UIImage(named: "Heart_Red"))
        return view
    }()
    
    let secondMbtiView: MbtiInfoView = {
        let view = MbtiInfoView(mbti: "ESTJ", explainText: "가 가장 맘에 든다고 평가했어요", image: UIImage(named: "Good_Select"))
        return view
    }()
    
    let thirdMbtiView: MbtiInfoView = {
        let view = MbtiInfoView(mbti: "ESTJ", explainText: "이 가장 별로라고 평가했어요", image: UIImage(named: "Bad_Select"))
        return view
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setHierarchy() {
        self.addSubview(detailHeaderView)
        self.addSubview(likeButton)
        self.addSubview(likeLabel)
        self.addSubview(evaluateButton)
        self.addSubview(evaluateLabel)
        self.addSubview(mbtiInfoStackView)
//        self.addSubview(evaluateNumberLabel)
        self.addSubview(summarytitleLabel)
        self.addSubview(summaryExplainLabel)
    }
    
    override func setupLayout() {
        detailHeaderView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
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
        
        mbtiInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(evaluateLabel.snp.bottom).offset(36)
            make.height.equalTo(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        summarytitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mbtiInfoStackView.snp.bottom).offset(36)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        
        summaryExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(summarytitleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension MovieDetailHeaderView {
    func configureUpdateUI(animationData: DetailAnimationData) {
        self.detailHeaderView.titleLabel.text = animationData.title
        self.detailHeaderView.subTitleLabel.text = ""
        self.summaryExplainLabel.text = animationData.plot
        
        let imageURL = URL(string: animationData.poster_img)
        self.detailHeaderView.moviePosterView.kf.setImage(with: imageURL)
    }
}

extension MovieDetailHeaderView {
    func updateLikeButtonUI(like: Bool) {
        switch like {
        case true:
            self.likeButton.setImage(UIImage(named: "LikeSelect"), for: .normal)
            self.likeLabel.textColor = .black5
        case false:
            self.likeButton.setImage(UIImage(named: "LikeNonSelect"), for: .normal)
            self.likeLabel.textColor = .black60
        }
    }
}

extension MovieDetailHeaderView {
    func updateGradeButtonUI(grade: Int) {
        switch grade {
        case 1, -1:
            self.evaluateButton.setImage(UIImage(named: "Good_Select"), for: .normal)
            self.evaluateLabel.textColor = .black5
        default:
            self.evaluateButton.setImage(UIImage(named: "Good_Nonselect"), for: .normal)
            self.evaluateLabel.textColor = .black60
        }
    }
}
