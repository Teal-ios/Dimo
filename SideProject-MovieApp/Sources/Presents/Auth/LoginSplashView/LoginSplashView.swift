//
//  LoginSplashView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/09.
//

import UIKit
import SnapKit
import Lottie

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
    
    let animationView: LottieAnimationView = {
        let lottieView = LottieAnimationView(name: "Dimo_splash_animation")
        lottieView.loopMode = .loop
        return lottieView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func setupLayout() {
        [bgView, bannerView, loginBottomView, animationView].forEach { self.addSubview($0) }

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
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(126)
        }
        
        animationView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(animationView.snp.width)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-40)
        }
    }
}
