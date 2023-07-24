//
//  StarView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/26.
//

import UIKit
import SnapKit

class StarView: BaseView {
    let mbtiLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle3
        label.textColor = .black5
        label.text = "ISFJ"
        return label
    }()
    
    lazy var starStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 8
        view.addArrangedSubview(star1ImageView)
        view.addArrangedSubview(star2ImageView)
        view.addArrangedSubview(star3ImageView)
        view.addArrangedSubview(star4ImageView)
        view.addArrangedSubview(star5ImageView)
        return view
    }()
    
    let star1ImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_rating_off")
        return view
    }()
    
    let star2ImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_rating_off")
        return view
    }()
    
    let star3ImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_rating_off")
        return view
    }()
    
    let star4ImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_rating_off")
        return view
    }()
    
    let star5ImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_rating_off")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    override func setHierarchy() {
        self.addSubview(mbtiLabel)
        self.addSubview(starStackView)
    }
    
    override func setupLayout() {
        mbtiLabel.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.centerY.equalToSuperview() // 수직 중앙 정렬 수정
            make.leading.equalToSuperview() // 왼쪽 여백 수정
        }
        
        starStackView.snp.makeConstraints { make in
            make.height.equalTo(star1ImageView.snp.height)
            make.centerY.equalToSuperview() // 수직 중앙 정렬 수정
            make.leading.equalTo(mbtiLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            // 왼쪽 여백 수정
        }
        
        star1ImageView.snp.makeConstraints { make in
            make.width.equalTo(star1ImageView.snp.height)
        }
        star2ImageView.snp.makeConstraints { make in
            make.width.equalTo(star1ImageView.snp.height)
        }
        star3ImageView.snp.makeConstraints { make in
            make.width.equalTo(star1ImageView.snp.height)
        }
        star4ImageView.snp.makeConstraints { make in
            make.width.equalTo(star1ImageView.snp.height)
        }
        star5ImageView.snp.makeConstraints { make in
            make.width.equalTo(star1ImageView.snp.height)
        }
    }
}
