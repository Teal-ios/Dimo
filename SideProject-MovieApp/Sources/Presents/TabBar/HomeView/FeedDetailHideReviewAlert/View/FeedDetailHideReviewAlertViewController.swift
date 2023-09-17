//
//  FeedDetailHideReviewAlertViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit
import SnapKit
import RxCocoa

final class FeedDetailHideReviewAlertViewController: BaseViewController {
    private let selfView = FeedDetailHideReviewAlertView()
    
    private let viewModel: FeedDetailHideReviewAlertViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: FeedDetailHideReviewAlertViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        let input = FeedDetailHideReviewAlertViewModel.Input(okButtonTapped: self.selfView.alertView.cancelButton.rx.tap, cancelButtonTapped: self.selfView.alertView.okButton.rx.tap, backgroundButtonTapped: self.selfView.alertView.backgroundButton.rx.tap)
        let _ = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        selfView.backgroundColor = .clear
    }
}
