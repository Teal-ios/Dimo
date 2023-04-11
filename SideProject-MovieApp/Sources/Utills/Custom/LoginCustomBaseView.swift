//
//  LoginCustomBaseView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/09.
//

import UIKit
import SnapKit

final class LoginCustomBaseView: UIView {

    let bannerDimoView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "banner")
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.addSubview(bannerDimoView)

        bannerDimoView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.32)
            make.height.equalTo(bannerDimoView.snp.width).multipliedBy(47/121)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(104)
        }
    }
}

