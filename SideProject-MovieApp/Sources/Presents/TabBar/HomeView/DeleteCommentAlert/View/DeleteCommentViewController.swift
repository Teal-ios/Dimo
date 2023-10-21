//
//  DeleteCommentAlertViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/21.
//

import UIKit
import SnapKit
import RxCocoa

final class DeleteCommentAlertViewController: BaseViewController {
    private let selfView = DeleteCommentAlertView()
    
    private let viewModel: DeleteCommentAlertViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: DeleteCommentAlertViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        let input = DeleteCommentAlertViewModel.Input(okButtonTapped: self.selfView.alertView.cancelButton.rx.tap, cancelButtonTapped: self.selfView.alertView.okButton.rx.tap)
        let _ = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        selfView.backgroundColor = .clear
    }
}
