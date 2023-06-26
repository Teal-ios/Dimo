//
//  PopupView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/28.
//

import UIKit
import SnapKit

class PopupView: BaseView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black100
        view.alpha = 0.35
        return view
    }()
    
    let basePopupView: UIView = {
        let view = UIView()
        view.backgroundColor = .black80
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
    
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func setupLayout() {
        [bgView, basePopupView, titleLabel, subtitleLabel, okButton].forEach { self.addSubview($0) }
        
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
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalTo(basePopupView)
        }
    }
}

