//
//  AllMbtiCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/09.
//

import UIKit

final class AllMbtiCollectionViewCell: BaseCollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.textAlignment = .center
        label.font = Font.body3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureContentView()
        self.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing).inset(12)
            make.bottom.equalTo(contentView.snp.bottom)
        }
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
    
    func configureLabelTextColor(_ color: UIColor) {
        label.textColor = color
    }
    
    func configureUI(isSelected: Bool = false) {
        if isSelected {
            contentView.backgroundColor = .black90
            contentView.layer.borderColor = UIColor.purple100.cgColor
            label.textColor = .black5
        } else {
            contentView.backgroundColor = .black90
            contentView.layer.borderColor = UIColor.black80.cgColor
            label.textColor = .black60
        }
    }
}
