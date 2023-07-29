//
//  MyMomentumBaseExceptionHandlingView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import UIKit
import SnapKit

class MyMomentumBaseExceptionHandlingView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title3
        label.textAlignment = .left
        label.textColor = .black5
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body3
        label.textColor = .black60
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, subtitle: String) {
        self.init()
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
    override func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(bgView)
        self.addSubview(subtitleLabel)
    }
    
    override func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        bgView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.edges.equalTo(bgView).inset(16)
        }
    }
}
