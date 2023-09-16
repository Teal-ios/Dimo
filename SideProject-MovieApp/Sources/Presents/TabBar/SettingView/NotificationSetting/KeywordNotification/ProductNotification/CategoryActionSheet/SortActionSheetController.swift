//
//  CategoryActionSheetController.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/09/16.
//

import UIKit

final class SortActionSheetController: BaseViewController {
    
    let sortActionSheetView = SortActionSheetView()
    
    override func loadView() {
        self.view = sortActionSheetView
    }
    
    override func viewDidLoad() {
        self.addBackgroundViewGesture()
    }
    
    func addBackgroundViewGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedBackgroundView))
        sortActionSheetView.addBackgroundViewGesture(tapGesture)
    }
    
    @objc func didTappedBackgroundView() {
        self.dismiss(animated: true)
    }
    
}
