//
//  RegisteredMbtiCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/09.
//

import UIKit

final class RegisteredMbtiCollectionViewCell: BaseCollectionViewCell {
    
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
    
    private let containerView: UIView = {
        let view = UIView()
        return view
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
        containerView.addSubview(label)
        containerView.addSubview(xImageView)
        contentView.addSubview(containerView)
    }
    
    override func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(20)
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        xImageView.snp.makeConstraints { make in
            make.width.equalTo(8)
            make.height.equalTo(8)
            make.leading.equalTo(label.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
}
