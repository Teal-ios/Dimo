//
//  Reactive+Extension.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/30.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {
    
    var isTapped: ControlProperty<Bool> {
        return controlProperty(editingEvents: .touchUpInside) { button in
            return button.isSelected
        } setter: { button, _ in
            return button.isSelected.toggle()
        }
    }
}
