//
//  TapUISlider.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/17.
//
import UIKit

final class TapUISlider: UISlider {
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let width = self.frame.size.width
    let tapPoint = touch.location(in: self)
    let fPercent = tapPoint.x/width
    let nNewValue = self.maximumValue * Float(fPercent)
    if nNewValue != self.value {
      self.value = nNewValue
    }
    return true
  }
}
