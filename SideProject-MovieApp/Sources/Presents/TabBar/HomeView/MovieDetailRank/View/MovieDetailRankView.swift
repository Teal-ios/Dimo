//
//  MovieDetailRankView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/26.
//

import UIKit
import SnapKit

class MovieDetailRankView: BaseView {
        
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
    
    let backgroundButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.title3
        label.text = "평가하기"
        label.textAlignment = .left
        return label
    }()
    
    let scopeStarView: ScopeStackView = {
        let view = ScopeStackView()
        view.setRatingImageView()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseCategoryView.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(baseCategoryView)
        self.addSubview(backgroundButton)
        self.addSubview(titleLabel)
        self.addSubview(scopeStarView)
    }
    
    override func setupLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(bgView)
            make.bottom.equalTo(baseCategoryView.snp.top)
        }
        
        baseCategoryView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(128)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(baseCategoryView.snp.top)
            make.height.equalTo(64)
        }
        
        scopeStarView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(baseCategoryView)
            make.width.equalTo(168)
        }
    }
}
