//
//  ModifyCommentView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/16.
//

import UIKit
import SnapKit

final class ModifyCommentView: BaseView {
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
    
    let deleteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.body2
        label.text = "삭제하기"
        label.textAlignment = .left
        return label
    }()
    
    let deleteButton: UIButton = {
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
        self.addSubview(deleteLabel)
        self.addSubview(deleteButton)
        self.addSubview(backgroundButton)
    }
    
    override func setupLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        baseCategoryView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(132)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(baseCategoryView.snp.top)
            make.height.equalTo(64)
        }
        
        deleteLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(deleteLabel)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.edges.equalTo(deleteLabel)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.bottom.equalTo(baseCategoryView.snp.top)
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
