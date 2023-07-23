//
//  FeedDetailDeleteViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/01.
//

import UIKit
import SnapKit
import RxCocoa

final class FeedDetailDeleteViewController: BaseViewController {
    private let selfView = FeedDetailDeleteView()
    
    private let viewModel: FeedDetailDeleteViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: FeedDetailDeleteViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        let input = FeedDetailDeleteViewModel.Input(okButtonTapped: self.selfView.alertView.okButton.rx.tap, cancelButtonTapped: self.selfView.alertView.cancelButton.rx.tap)
        let _ = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        selfView.backgroundColor = .clear
    }
}
