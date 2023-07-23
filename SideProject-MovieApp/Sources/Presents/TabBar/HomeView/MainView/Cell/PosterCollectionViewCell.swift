//
//  PosterCollectionViewCell.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import SnapKit
import Kingfisher

class PosterCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "PosterCollectionViewCell"
    
    let gradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.gradientWhite.cgColor ,UIColor.gradientBlack.cgColor]
        gradient.locations = [0.3 , 1.0]
        return gradient
    }()
    
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "loginBottom")
        view.backgroundColor = .black5
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title2
        label.textAlignment = .center
        return label
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.layer.cornerRadius = 8
        gradientLayer.frame = gradientView.bounds
    }
    
    
    
    override func configure() {
        [imgView, gradientView, titleLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
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
    
    func configureAttribute(with item: AnimationData) {
        let imageUrl = URL(string: item.poster)
        imgView.kf.setImage(with: imageUrl)
        imgView.contentMode = .scaleToFill
        titleLabel.text = item.title
    }
}

