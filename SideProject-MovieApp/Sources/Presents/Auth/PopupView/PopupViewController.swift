//
//  PopupViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/28.
//

import UIKit
import RxCocoa

class PopupViewController: BaseViewController {
    private let popupView = PopupView()
    
    private var viewModel: PopupViewModel
    override func loadView() {
        view = popupView
    }
    init(viewModel: PopupViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        
        let input = PopupViewModel.Input(okButtonTapped: popupView.okButton.rx.tap)
        
        let output = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        popupView.backgroundColor = .clear
    }
}
