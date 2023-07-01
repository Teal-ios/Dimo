//
//  FeedDetailMoreMyViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import UIKit
import RxCocoa

final class FeedDetailMoreMyViewController: BaseViewController {
    private let selfView = FeedDetailMoreMyView()
    
    private var viewModel: FeedDetailMoreMyViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: FeedDetailMoreMyViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        
        let input = FeedDetailMoreMyViewModel.Input(modifyButtonTapped: selfView.selfView.movieButton.rx.tap, deleteButtonTapped: selfView.selfView.dramaButton.rx.tap)
        
        let output = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
}
