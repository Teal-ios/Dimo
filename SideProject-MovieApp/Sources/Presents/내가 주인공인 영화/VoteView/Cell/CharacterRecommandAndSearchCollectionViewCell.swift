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
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .suitFont(ofSize: 16, weight: .ExtraBold)
//        label.textColor = .white100
//        label.textAlignment = .left
//        label.text = "캐릭터\n랜덤 추천"
//        label.numberOfLines = 0
//        return label
//    }()
//
    let imgView: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(systemName: "xmark.circle")
//        view.layer.cornerRadius = 4
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.black20.cgColor
        return view
    }()
        
    override func configure() {
        [imgView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
//        titleLabel.snp.makeConstraints { make in
//            make.leading.equalTo(imgView.snp.leading).inset(16)
//            make.top.equalTo(imgView.snp.top).inset(16)
//        }
    }
}
