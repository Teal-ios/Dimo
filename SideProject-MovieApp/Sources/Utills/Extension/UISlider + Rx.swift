//
//  UISlider + Rx.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/02.
//
//
//extension Reactive where Base: UISlider {
//    
//    /// Reactive wrapper for `value` property.
//    public var value: ControlProperty<Float> {
//        return base.rx.controlPropertyWithDefaultEvents(
//            getter: { slider in
//                slider.value
//            }, setter: { slider, value in
//                slider.value = value
//            }
//        )
//    }
//}
