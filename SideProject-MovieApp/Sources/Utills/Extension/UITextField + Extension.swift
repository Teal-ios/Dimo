//
//  UITextField + Extension.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/25.
//

import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
