//
//  ReviewExceptionView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import UIKit
import SnapKit

class ReviewExceptionView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    let reviewContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    convenience init(explainText: String) {
        self.init()
        self.explainLabel.text = explainText
    }
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(reviewContainView)
        self.addSubview(explainLabel)
    }
    
    override func setupLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        reviewContainView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(bgView).inset(16)
            make.height.equalTo(74)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.edges.equalTo(reviewContainView).inset(16)
        }
    }
}
