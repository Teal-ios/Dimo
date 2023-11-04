//
//  TermsOfUseButton.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/24.
//

import UIKit
import SnapKit

final class TermsOfUseButton: UIButton {
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check_gray")
        return imageView
    }()
    
    private let termsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body2
        label.textColor = .black5
        return label
    }()
    
    private let seeMoreButton: SeeMoreButton = {
        let button = SeeMoreButton()
        button.isHidden = true
        return button
    }()
    
    init(termsTitle: String, isHiddenSeeMoreButton: Bool) {
        self.termsTitleLabel.text = termsTitle
        self.seeMoreButton.isHidden = isHiddenSeeMoreButton
        super.init()
        self.setHierarchy()
        self.setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setHierarchy()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TermsOfUseButton {
    
    func setHierarchy() {
        self.addSubview(checkImageView)
        self.addSubview(termsTitleLabel)
        self.addSubview(seeMoreButton)
    }
    
    func setupLayout() {
        checkImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(4.0)
            make.width.equalTo(24.0)
            make.height.equalTo(24.0)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        termsTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImageView.snp.leading).offset(12.0)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}

final class SeeMoreButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("보기", for: .normal)
        self.setTitleColor(.black60, for: .normal)
        self.titleLabel?.font = .suitFont(ofSize: 12.0)
        
        let underLineView = UIView()
        underLineView.backgroundColor = .black60
        
        self.addSubview(underLineView)
        underLineView.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.width.equalTo(self.titleLabel?.snp.width ?? 0)
            make.top.equalTo(titleLabel?.snp.bottom ?? self.snp.bottom).offset(1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
