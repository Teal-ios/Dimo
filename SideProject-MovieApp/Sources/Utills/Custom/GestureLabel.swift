//
//  GestureLabel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/13.
//

//import UIKit.UILabel
//import SnapKit
//import RxCocoa
//import RxSwift
//
//class GestureLabel: UILabel {
//
//    var tapped = BehaviorSubject<Bool>(value: false)
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    convenience init(text: String) {
//        self.init()
//        self.text = text
//        self.textColor = Color.caption
//        self.font = Font.caption
//        self.isUserInteractionEnabled = true
//        self.addCharacterSpacing(0.04)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
//        self.addGestureRecognizer(tapGesture)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension GestureLabel {
//    @objc func labelClicked() {
//        print("이게먹니")
//        self.tapped.onNext(true)
//    }
//}
//
