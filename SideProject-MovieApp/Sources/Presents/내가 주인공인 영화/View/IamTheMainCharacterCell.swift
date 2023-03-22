//
//  IamTheMainCharacterCell.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/21.
//

import UIKit
import SnapKit

class IamTheMainCharacterCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark.circle")
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemOrange.cgColor
        return imageView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        imageView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
