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
    static let purple100 = UIColor.makeColor(from: "#705FFC")
    static let purple80 = UIColor.makeColor(from: "#8D7FFD")
    static let purple60 = UIColor.makeColor(from: "#A99FFD")
    static let purple40 = UIColor.makeColor(from: "#C6BFFE")
    static let purple20 = UIColor.makeColor(from: "#E2DFFE")
    
    /// Black
    static let black100 = UIColor.makeColor(from: "#0F0F0F")
    static let black90 =  UIColor.makeColor(from: "#272727")
    static let black80 = UIColor.makeColor(from: "#3F3F3F")
    static let black60 = UIColor.makeColor(from: "#7D7C7B")
    static let black40 = UIColor.makeColor(from: "#A8A8A7")
    static let black20 = UIColor.makeColor(from: "#D4D3D3")
    static let black10 = UIColor.makeColor(from: "#E9E9E9")
    static let black5 = UIColor.makeColor(from: "#F4F4F4")
    /// White
    static let white100 = UIColor.makeColor(from: "#FFFFFF")
    
    /// Error
    static let error = UIColor.makeColor(from: "#F24D46")
    static let gradientWhite = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 0)
    static let gradientBlack = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
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
