//
//  DetailHeaderView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit
import SnapKit

final class DetailHeaderView: BaseView {
    
    let moviePosterView: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(named: "finishSignUp")
        view.backgroundColor = .black5
        return view
    }()
    
    let gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title1
        label.textColor = .black5
        label.textAlignment = .center

       return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String?, subTitle: String?) {
        self.init()
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.setGradient(color1: .gradientWhite, color2: .gradientBlack)
        
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        self.addSubview(moviePosterView)
        self.addSubview(gradientView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        let safeArea = self.safeAreaLayoutGuide
        
        moviePosterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).offset(-24)
            make.height.equalTo(24)
            make.horizontalEdges.equalTo(safeArea)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-8)
            make.horizontalEdges.equalTo(safeArea)
            make.height.equalTo(32)
        }
    }
}
