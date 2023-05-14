//
//  MbtiCharacterCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit

class MbtiCharacterCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "MbtiCharacterCollectionViewCell"

    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.backgroundColor = .white100
        view.clipsToBounds = true
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
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
