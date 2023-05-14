//
//  SettingBaseCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit

class SettingBaseCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "SettingBaseCollectionViewCell"


    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .white100
        label.textAlignment = .left
        return label
    }()
    
        
    override func configure() {
        [titleLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
