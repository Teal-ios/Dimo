//
//  RegisteredKeywordCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/13.
//

import UIKit

final class RegisteredKeywordCollectionViewCell: BaseCollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.textAlignment = .center
        label.font = Font.body3
        return label
    }()
    
    let xImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        imageView.image = UIImage(named: "X")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContentView() {
        contentView.backgroundColor = .black90
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black80.cgColor
    }
    
    func configure(text: String) {
        self.label.text = text
    }
    
    override func setHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(xImageView)
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing).offset(-28)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        xImageView.snp.makeConstraints { make in
            make.width.equalTo(8)
            make.height.equalTo(8)
            make.leading.equalTo(label.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
}

