//
//  MyMomentumDigExceptionHandlingView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import UIKit
import SnapKit

class MyMomentumDigExceptionHandlingView: BaseView {
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
    
    let digMeButton: OnboardingButton = {
        return OnboardingButton(title: "DIG ME!로 이동하기", ofSize: 14)
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
        self.addSubview(digMeButton)
    }
    
    override func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(32)
        }
        
        digMeButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(32)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(digMeButton.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
