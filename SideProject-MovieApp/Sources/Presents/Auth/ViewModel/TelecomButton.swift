//
//  TelecomButton.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/28.
//

import UIKit

class TelecomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(title: String?, foregroundColor: UIColor?) {
        self.init()
        var configuration = UIButton.Configuration.gray()
        var attrStr = AttributedString(title ?? "")
        attrStr.font = .suitFont(ofSize: 16, weight: .Medium)
        configuration.attributedTitle = attrStr
        configuration.baseBackgroundColor = .black90
        configuration.baseForegroundColor = foregroundColor
        configuration.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        self.contentHorizontalAlignment = .left
        self.configuration = configuration
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
