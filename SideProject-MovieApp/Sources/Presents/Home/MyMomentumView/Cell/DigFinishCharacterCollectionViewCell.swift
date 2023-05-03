//
//  DigFinishCharacterCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/03.
//

import UIKit
import SnapKit

class DigFinishCharacterCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "DigFinishCharacterCollectionViewCell"

    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "finishSignUp")
        view.backgroundColor = .white100
        return view
    }()
    
    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .white100
        label.textAlignment = .center
        label.text = "정대만"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
    }
        
    override func configure() {
        [imgView, characterNameLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(imgView.snp.width)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(imgView)
            make.height.equalTo(24)
        }
    }
}
