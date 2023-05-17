//
//  CategoryCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/16.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        return view
    }()
    
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption
        label.textColor = .black60
        label.textAlignment = .center
        label.text = "정대만"
        return label
    }()
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        [bgView, categoryLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(bgView.snp.horizontalEdges).inset(8)
            make.verticalEdges.equalTo(bgView.snp.verticalEdges).inset(4)
        }
    }
}
