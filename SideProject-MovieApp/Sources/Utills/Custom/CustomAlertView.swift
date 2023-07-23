//
//  CustomAlertView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import SnapKit

class CustomAlertView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.029, green: 0.028, blue: 0.028, alpha: 0.5)
        return view
    }()
    
    let containView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Font.title3
        label.textColor = .black5
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Font.subtitle2
        label.textColor = .black60
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    let okButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, subtitle: String, okButtonTitle: String) {
        self.init()
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        var configuration = UIButton.Configuration.gray()
        var attrStr = AttributedString(okButtonTitle)
        attrStr.font = .suitFont(ofSize: 16, weight: .Medium)
        configuration.attributedTitle = attrStr
        configuration.baseBackgroundColor = .black90
        configuration.baseForegroundColor = .purple100
        configuration.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        self.okButton.configuration = configuration
        
        var cancelAttrStr = AttributedString("아니요")
        cancelAttrStr.font = .suitFont(ofSize: 16, weight: .Medium)
        var cancelConfiguration = UIButton.Configuration.gray()
        cancelConfiguration.attributedTitle = cancelAttrStr
        cancelConfiguration.baseBackgroundColor = .black90
        cancelConfiguration.baseForegroundColor = .white
        configuration.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        self.cancelButton.configuration = cancelConfiguration
    }
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(containView)
        self.addSubview(titleLabel)
        self.addSubview(cancelButton)
        self.addSubview(okButton)
        self.addSubview(subtitleLabel)
    }
    
    override func setupLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(187)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containView.snp.top).offset(42)
            make.height.equalTo(18)
            make.horizontalEdges.equalTo(containView).inset(4)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalTo(containView.snp.leading)
            make.width.equalTo(containView.snp.width).multipliedBy(0.5)
            make.height.equalTo(52)
            make.bottom.equalTo(containView.snp.bottom)
        }
        
        okButton.snp.makeConstraints { make in
            make.trailing.equalTo(containView.snp.trailing)
            make.width.equalTo(containView.snp.width).multipliedBy(0.5)
            make.height.equalTo(52)
            make.bottom.equalTo(containView.snp.bottom)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(okButton.snp.top)
            make.horizontalEdges.equalTo(containView).inset(4)
        }
    }
}
