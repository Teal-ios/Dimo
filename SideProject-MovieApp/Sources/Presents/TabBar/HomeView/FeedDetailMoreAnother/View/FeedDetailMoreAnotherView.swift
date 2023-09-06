//
//  FeedDetailMoreAnotherView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//


import UIKit
import SnapKit

class FeedDetailMoreAnotherView: BaseView {
        
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black100
        view.alpha = 0.35
        return view
    }()
    
    let baseCategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.title3
        label.text = "더보기"
        label.textAlignment = .left
        return label
    }()
    
    let reviewBlindLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.body2
        label.text = "리뷰 가리기"
        label.textAlignment = .left
        return label
    }()
    
    let reportLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.body2
        label.text = "작성자 신고하기"
        label.textAlignment = .left
        return label
    }()
    
    let allReviewBlindLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.body2
        label.text = "작성자의 모든 리뷰 가리기"
        label.textAlignment = .left
        return label
    }()
    
    let reviewBlindButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let reportButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let allReviewBlindButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let backgroundButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        baseCategoryView.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(baseCategoryView)
        self.addSubview(titleLabel)
        self.addSubview(reviewBlindLabel)
        self.addSubview(reportLabel)
        self.addSubview(allReviewBlindLabel)
        self.addSubview(reviewBlindButton)
        self.addSubview(reportButton)
        self.addSubview(allReviewBlindButton)
        self.addSubview(backgroundButton)
    }
    
    override func setupLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        baseCategoryView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(236)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(baseCategoryView.snp.top)
            make.height.equalTo(64)
        }
        
        reviewBlindLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(52)
        }
        
        reviewBlindButton.snp.makeConstraints { make in
            make.edges.equalTo(reviewBlindLabel)
        }
        
        reportLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(reviewBlindButton.snp.bottom)
            make.height.equalTo(52)
        }
        
        reportButton.snp.makeConstraints { make in
            make.edges.equalTo(reportLabel)
        }
        
        allReviewBlindLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(reportButton.snp.bottom)
            make.height.equalTo(52)
        }
        
        allReviewBlindButton.snp.makeConstraints { make in
            make.edges.equalTo(allReviewBlindLabel)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.bottom.equalTo(baseCategoryView.snp.top)
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
