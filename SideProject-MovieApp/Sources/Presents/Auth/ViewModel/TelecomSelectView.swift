//
//  TelecomSelectView.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/04/02.
//

import UIKit

class TelecomSelecView: UIView {
    let skt: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    let kt: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let uPlus: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
