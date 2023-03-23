//
//  Font+Extension.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/22.
//

import UIKit

extension UIFont {
    static func suitFont(ofSize: CGFloat, weight: SuitFont = .Regular) -> UIFont? {
        return UIFont(name: "SUIT-\(weight.rawValue)", size: ofSize)
    }
}
