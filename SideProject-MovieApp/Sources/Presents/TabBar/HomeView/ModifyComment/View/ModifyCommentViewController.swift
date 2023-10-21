//
//  ModifyCommentViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/20.
//

import UIKit
import RxCocoa

final class ModifyCommentViewController: BaseViewController {
    private let selfView = ModifyCommentView()
    
    private var viewModel: ModifyCommentViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: ModifyCommentViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        
        let input = ModifyCommentViewModel.Input( deleteButtonTapped: selfView.deleteButton.rx.tap, backgroundButtonTapped: selfView.backgroundButton.rx.tap)
        
        let output = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
}
