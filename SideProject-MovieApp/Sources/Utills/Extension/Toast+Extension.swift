//
//  Toast+Extension.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/07.
//

import UIKit
import Toast

extension ToastStyle {
    
    static var dimoToastStyle: ToastStyle {
        var toastStyle = ToastStyle()
        toastStyle.messageFont = .suitFont(ofSize: 14.0, weight: .Medium) ?? UIFont()
        toastStyle.messageColor = .black80
        toastStyle.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.6)
        toastStyle.horizontalPadding = 16.0
        toastStyle.verticalPadding = 8.0
        toastStyle.cornerRadius = 8.0
        return toastStyle
    }
}
