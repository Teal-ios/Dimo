//
//  LoginStartView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

import UIKit
import SnapKit

final class LoginStartView: BaseView {
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
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "KakaoLoginButton"), for: .normal)
        return button
    }()
    
    let googleLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "GoogleLoginButton"), for: .normal)
        return button
    }()
    
    let dimoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "DimoLoginButton"), for: .normal)
        return button
    }()
    
    let signupButton: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.textColor = Color.caption
        label.font = Font.caption
        label.addCharacterSpacing(0.04)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func setupLayout() {
        [bgView, bannerView, kakaoLoginButton, googleLoginButton, dimoLoginButton, signupButton].forEach { self.addSubview($0) }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        bannerView.snp.makeConstraints { make in
            make.width.equalTo(121)
            make.height.equalTo(47)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(104)
        }
        
        signupButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(60)
            make.height.equalTo(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-36)
        }
        
        dimoLoginButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            make.bottom.equalTo(signupButton.snp.top).offset(-24)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            make.bottom.equalTo(dimoLoginButton.snp.top).offset(-24)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            make.bottom.equalTo(googleLoginButton.snp.top).offset(-24)
        }
    }
}

