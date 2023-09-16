//
//  CategoryButton.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/16.
//

import UIKit
import SnapKit

final class CategoryButton: UIButton {
    
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 4.0
        stackView.axis = .horizontal
        return stackView
    }()
    
    let buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_bottom")
        return imageView
    }()
    
    convenience init(title: String) {
        self.init()
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black80.cgColor
        self.backgroundColor = .black90
        self.tintColor = Color.caption
        self.buttonTitleLabel.text = title
        self.addSubviews()
        self.setLayoutConstraints()
    }
    
    
    func addSubviews() {
        containerStackView.addArrangedSubview(buttonTitleLabel)
        containerStackView.addArrangedSubview(arrowImageView)
        self.addSubview(containerStackView)
    }
    
    func setLayoutConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.width.equalTo(16.0)
            make.height.equalTo(16.0)
        }
    }
}
