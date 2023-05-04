//
//  VoteCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import UIKit
import SnapKit

class VoteCollectionViewCell: BaseCollectionViewCell {
    static let voteCollectionViewIdentifier = "VoteCollectionViewCell"

    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = Font.body2
        view.text = "정대만"
        return view
    }()
    
    let movieTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Font.caption
        view.textColor = Color.caption
        view.text = "더퍼스트슬램덩크"

        return view
    }()

    let imgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .label
        view.image = UIImage(systemName: "person.fill")
        view.clipsToBounds = true
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = imgView.frame.width / 2
    }
        
    override func configure() {
        addSubview(imgView)
        [nameLabel, movieTitleLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.width.equalTo(imgView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(8)
            make.top.equalTo(imgView.snp.top).offset(4)
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
    }
}
