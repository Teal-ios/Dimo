//
//  CardCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit
import SnapKit

class CardCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "CardCollectionViewCell"

    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.backgroundColor = .black5
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

extension CardCollectionViewCell {
    func configureAttribute(with item: Hit) {
        let imageUrl = URL(string: item.poster_img)
        imgView.kf.setImage(with: imageUrl)
        imgView.contentMode = .scaleToFill
    }
    
    func configureAttribute(likeContent: LikeContent) {
        let imageURL = URL(string: likeContent.poster_img)
        imgView.kf.setImage(with: imageURL)
        imgView.contentMode = .scaleToFill
    }
    
    func configureAttribute(hit: Hit) {
        let imageURL = URL(string: hit.poster_img)
        imgView.kf.setImage(with: imageURL)
        imgView.contentMode = .scaleToFill
    }
}
