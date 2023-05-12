//
//  PosterCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit

class PosterCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "PosterCollectionViewCell"

    lazy var gradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "loginBottom")
        view.backgroundColor = .white100
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title2
        label.text = "더 콘크리트"
        label.textAlignment = .center
        return label
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "SUIT-SemiBold", size: 12)
        label.text = "기막성 이병현 박시콩"
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = 8
    }
        
    override func configure() {
        [imgView, characterLabel, titleLabel, gradientView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(48)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

