//
//  FeedDetailHideUserAlertViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit
import SnapKit
import RxCocoa

final class FeedDetailHideUserAlertViewController: BaseViewController {
    private let selfView = FeedDetailHideUserAlertView()
    
    private let viewModel: FeedDetailHideUserAlertViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: FeedDetailHideUserAlertViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        let input = FeedDetailHideUserAlertViewModel.Input(okButtonTapped: self.selfView.alertView.cancelButton.rx.tap, cancelButtonTapped: self.selfView.alertView.okButton.rx.tap, backgroundButtonTapped: self.selfView.alertView.backgroundButton.rx.tap)
        let _ = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        selfView.backgroundColor = .clear
    }
}
