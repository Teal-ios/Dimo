//
//  UIColor+Extension.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/22.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(a) / 255.0)
    }
    
    convenience init(rgb: Int) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
    }
}

extension UIColor {
    /// Purple
    static let purple100 = UIColor(rgb: 0x705FFC)
    static let purple80 = UIColor(rgb: 0x8D7FFD)
    static let purple60 = UIColor(rgb: 0xA99FFD)
    static let purple40 = UIColor(rgb: 0xC6BFFE)
    static let purple20 = UIColor(rgb: 0xE2DFFE)
    
    /// Black
    static let black100 = UIColor(rgb: 0x262523)
    static let black80 = UIColor(rgb: 0x51514F)
    static let black60 = UIColor(rgb: 0x7D7C7B)
    static let black40 = UIColor(rgb: 0xA8A8A7)
    static let black20 = UIColor(rgb: 0xD4D3D3)
    static let black10 = UIColor(rgb: 0xE9E9E9)
    static let black5 = UIColor(rgb: 0xF4F4F4)
    
    /// White
    static let white100 = UIColor(rgb: 0xFFFFFF)
    
    /// Error
    static let error = UIColor(rgb: 0xF24D46)
}

extension UIColor {
    /// hex sting -> UIColor
    static func makeColor(from hex: String) -> UIColor {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >>  8) & 0xFF) / 255.0
        let blue = Double((rgb >>  0) & 0xFF) / 255.0
        
        return .init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIColor {
    static let backgroundGray = makeColor(from: "#272727")
    static let naviColor = makeColor(from: "#7D7C7B")

}

