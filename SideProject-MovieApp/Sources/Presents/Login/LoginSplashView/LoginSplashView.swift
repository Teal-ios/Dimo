//
//  LoginSplashView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/09.
//

import UIKit
import SnapKit

final class LoginSplashView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let bannerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "banner")
        return view
    }()
    
    let loginBottomView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "loginBottom")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupLayout() {
        [bgView, bannerView, loginBottomView].forEach { self.addSubview($0) }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bannerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.32)
            make.height.equalTo(bannerView.snp.width).multipliedBy(0.39)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(104)
        }
        
        loginBottomView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(loginBottomView.snp.width).multipliedBy(0.7)
        }
    }
}
