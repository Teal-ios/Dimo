//
//  IamTheMainCharacterCell.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/21.
//

import UIKit
import SnapKit

class IamTheMainCharacterCell: BaseCell {
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
             
    }
    
    override func setupLayout() {
        [imageView].forEach { self.addSubview($0) }
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
