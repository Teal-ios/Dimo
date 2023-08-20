//
//  BaseCollectionViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setHierarchy()
        setConstraints()
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() { }
    func configure() { }
    func setConstraints() { }
    
}
