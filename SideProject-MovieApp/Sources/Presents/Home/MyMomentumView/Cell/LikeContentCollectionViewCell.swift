//
//  likeContentCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import SnapKit

class LikeContentCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "LikeContentCollectionViewCell"

    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.backgroundColor = .white100
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        [imgView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
