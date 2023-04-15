//
//  wordButtonLabel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/15.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class WordLabelButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init()
        var configuration = UIButton.Configuration.gray()
        var attrStr = AttributedString(text)
        attrStr.font = Font.caption
        configuration.attributedTitle = attrStr
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = Color.caption
        self.contentHorizontalAlignment = .left
        self.configuration = configuration
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


