//
//  OnboardingButton.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit

class OnboardingButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(title: String) {
        self.init()
        var configuration = UIButton.Configuration.gray()
        var titleAttr = AttributedString.init(title)
        titleAttr.font = .suitFont(ofSize: 14, weight: .Medium)
        configuration.attributedTitle = titleAttr
        configuration.cornerStyle = .fixed
        configuration.baseBackgroundColor = .purple100
        configuration.baseForegroundColor = .white
        self.configuration = configuration
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
