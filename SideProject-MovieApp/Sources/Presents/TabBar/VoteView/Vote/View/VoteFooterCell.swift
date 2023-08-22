//
//  VoteFooterView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/22.
//

import UIKit
import SnapKit

class VoteFooterCell: BaseCollectionViewCell {
    static let identifier = "VoteFooterView"
    
    let characterMoreTextButton: WordLabelButton = {
        let button = WordLabelButton(text: "더 많은 캐릭터 보러가기")
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    
    override func configure() {
        addSubview(characterMoreTextButton)
    }
    
    override func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        characterMoreTextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.top.equalTo(safeArea).offset(24)
            make.height.equalTo(16)
        }
    }
}
