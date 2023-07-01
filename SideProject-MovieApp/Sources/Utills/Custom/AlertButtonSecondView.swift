//
//  AlertButtonSecondView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/01.
//

import UIKit
import SnapKit

class AlertButtonSecondView: BaseView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black100
        view.alpha = 0.35
        return view
    }()
    
    let basePopupView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black5
        label.font = Font.title3
        label.text = "존재하지 않는 회원정보"
        label.textAlignment = .center
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black60
        label.font = Font.body3
        label.numberOfLines = 0
        label.text = "일치하는 회원 정보가 없습니다.\n아이디 또는 비밀번호를 다시 확인해 주세요."
        label.textAlignment = .center
        return label
    }()
    
    let okButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white100
        label.font = Font.button
        return label
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let cancelButtonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .purple100
        label.font = Font.button
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, subtitle: String, okButtonTitle: String, cancelButtonTitle: String) {
        self.init()
        titleLabel.text = title
        subtitleLabel.text = subtitle
        okButtonLabel.text = okButtonTitle
        cancelButtonLabel.text = cancelButtonTitle

    }
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(basePopupView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(okButtonLabel)
        self.addSubview(okButton)
        self.addSubview(cancelButtonLabel)
        self.addSubview(cancelButton)
    }
    
    override func setupLayout() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        basePopupView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(187)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(basePopupView.snp.top).inset(40)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(basePopupView)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(42)
            make.leading.trailing.equalTo(basePopupView)
        }
        
        okButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.width.equalTo(basePopupView.snp.width).multipliedBy(0.5)
            make.leading.bottom.equalTo(basePopupView)
        }
        
        okButton.snp.makeConstraints { make in
            make.edges.equalTo(okButtonLabel)
        }
        
        cancelButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.width.equalTo(basePopupView.snp.width).multipliedBy(0.5)
            make.trailing.bottom.equalTo(basePopupView)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.edges.equalTo(cancelButtonLabel)
        }
    }
}
