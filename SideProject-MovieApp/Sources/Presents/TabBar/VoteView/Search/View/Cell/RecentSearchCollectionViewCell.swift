//
//  RecentSearchCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/04.
//

import UIKit
import SnapKit

class RecentSearchCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "RecentSearchCollectionViewCell"

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black80.cgColor
        return view
    }()
    
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black5
        label.textAlignment = .center
        label.text = "정대만"
        return label
    }()
    
    let xView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "X")
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        self.addSubview(bgView)
        self.addSubview(categoryLabel)
        self.addSubview(xView)
    }
    
    override func setConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(bgView.snp.leading).offset(8)
            make.trailing.equalTo(bgView.snp.trailing).offset(-28)
            make.verticalEdges.equalTo(bgView.snp.verticalEdges).inset(4)
        }
        
        xView.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(4)
            make.height.width.equalTo(8)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension RecentSearchCollectionViewCell {
    func configureAttribute(with item: AnimationData) {
        categoryLabel.text = item.characters[0].characterName
    }
}
