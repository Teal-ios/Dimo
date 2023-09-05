//
//  ModifyWriteView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/04.
//

import UIKit
import SnapKit

final class ModifyWriteView: BaseView {
    
    let navigationContainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let cancelLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.textColor = .black40
        label.text = "취소"
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.textColor = .black80
        label.text = "등록"
        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        return button
    }()
        
    let totalSpoilerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black90
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black80.cgColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let spoilerCheckImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check_gray")
        view.contentMode = .center
        return view
    }()
    
    let spoilerLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.textColor = .black60
        label.text = "스포일러 포함"
        return label
    }()
    
    let spoilerButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let reviewTextView: UITextView = {
       let view = UITextView()
        view.text = "정대만에 대한 생각을 자유롭게 남겨 주세요"
        view.textColor = .black80
        return view
    }()
    
    override func setHierarchy() {
        self.addSubview(navigationContainView)
        self.addSubview(cancelLabel)
        self.addSubview(cancelButton)
        self.addSubview(registerLabel)
        self.addSubview(registerButton)
        self.addSubview(totalSpoilerView)
        self.addSubview(spoilerCheckImageView)
        self.addSubview(spoilerLabel)
        self.addSubview(spoilerButton)
        self.addSubview(reviewTextView)
    }
    
    override func setupLayout() {
        navigationContainView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(49)
        }
        
        cancelLabel.snp.makeConstraints { make in
            make.leading.equalTo(navigationContainView.snp.leading)
            make.verticalEdges.equalTo(navigationContainView).inset(16)
            make.width.equalTo(28)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.edges.equalTo(cancelLabel)
        }
        
        registerLabel.snp.makeConstraints { make in
            make.trailing.equalTo(navigationContainView.snp.trailing)
            make.verticalEdges.equalTo(navigationContainView).inset(16)
            make.width.equalTo(28)
        }
        
        registerButton.snp.makeConstraints { make in
            make.edges.equalTo(registerLabel)
        }
        
        totalSpoilerView.snp.makeConstraints { make in
            make.top.equalTo(navigationContainView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
        
        spoilerCheckImageView.snp.makeConstraints { make in
            make.centerY.equalTo(totalSpoilerView)
            make.leading.equalTo(totalSpoilerView).offset(8)
            make.width.height.equalTo(24)
        }
        
        spoilerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalSpoilerView)
            make.leading.equalTo(spoilerCheckImageView.snp.trailing).offset(8)
            make.trailing.equalTo(totalSpoilerView.snp.trailing).inset(8)
            make.height.equalTo(24)
        }
        
        spoilerButton.snp.makeConstraints { make in
            make.edges.equalTo(totalSpoilerView)
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(spoilerButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension ModifyWriteView {
    func updateTextValid(valid: Bool) {
        if valid == true {
            spoilerCheckImageView.image = UIImage(named: "check_purple")
            totalSpoilerView.layer.borderColor = UIColor.purple100.cgColor
            spoilerLabel.textColor = .black5
        } else {
            spoilerCheckImageView.image = UIImage(named: "check_gray")
            totalSpoilerView.layer.borderColor = UIColor.black80.cgColor
            spoilerLabel.textColor = .black60
        }
    }
}

extension ModifyWriteView {
    
}
