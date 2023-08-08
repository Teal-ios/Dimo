//
//  CategoryView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit

class CategoryView: BaseView {
        
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
        label.text = "카테고리"
        label.textAlignment = .left
        return label
    }()
    
    let movieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.body2
        label.text = "영화"
        label.textAlignment = .left
        return label
    }()
    
    let movieButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let animationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body2
        label.text = "애니"
        label.textAlignment = .left
        return label
    }()
    
    let animationButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseCategoryView.layer.cornerRadius = 8
    }
    
    override func setupLayout() {
        [bgView, baseCategoryView, titleLabel, movieLabel, movieButton, animationLabel, animationButton].forEach { self.addSubview($0) }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        baseCategoryView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(168)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(baseCategoryView.snp.top)
            make.height.equalTo(64)
        }
        
        movieLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(52)
        }
        
        movieButton.snp.makeConstraints { make in
            make.edges.equalTo(movieLabel)
        }
        
        animationLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(movieButton.snp.bottom)
            make.height.equalTo(52)
        }
        
        animationButton.snp.makeConstraints { make in
            make.edges.equalTo(animationLabel)
        }
    }
}

extension CategoryView {
    func updateCategory(category: String) {
        if category == "영화" {
            animationLabel.textColor = .black60
            movieLabel.textColor = .black5
        } else {
            animationLabel.textColor = .black5
            movieLabel.textColor = .black60
        }
    }
}
