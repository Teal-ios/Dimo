//
//  CharactorRecommandAndSearchCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit
import SnapKit

class CharacterRecommandAndSearchCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "CharacterRecommandAndSearchCollectionViewCell"

    let imgView: UIImageView = {
        let view = UIImageView()
        return view
    }()
        
    override func configure() {
        [imgView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension CharacterRecommandAndSearchCollectionViewCell {
    func configureAttribute(with item: CharacterInfo) {
        imgView.image = UIImage(named: item.character_img)
    }
}
