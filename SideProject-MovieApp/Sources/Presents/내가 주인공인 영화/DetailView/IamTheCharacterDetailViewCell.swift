//
//  IamTheCharacterDetailViewCell.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/23.
//

import UIKit

class IamTheCharacterDetailViewCell: BaseCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark.circle")
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemOrange.cgColor
        return imageView
    }()
   
    let movieLabel: UILabel = {
        let label = UILabel()
        label.font = .suitFont(ofSize: 12)
        label.textAlignment = .center
        label.text = "영화 제목"
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        [imageView, movieLabel].forEach { self.addSubview($0) }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(4)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
        }
        movieLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(4)
        }
    }
    
    override func setupLayout() {
        [imageView, movieLabel].forEach { self.addSubview($0) }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(4)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
        }
        movieLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(4)
        }
    }
    
}
