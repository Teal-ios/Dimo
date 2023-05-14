//
//  UIView + Extension.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/12.
//

import UIKit

extension UIView {
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.6 , 1.0]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}

