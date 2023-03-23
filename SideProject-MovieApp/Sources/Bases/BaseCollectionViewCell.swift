//
//  BaseCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/23.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() { }
}
