//
//  FeedDetailMoreAnotherViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit
import RxCocoa

final class FeedDetailMoreAnotherViewController: BaseViewController {
    private let selfView = FeedDetailMoreAnotherView()
    
    private var viewModel: FeedDetailMoreAnotherViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: FeedDetailMoreAnotherViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        
        let input = FeedDetailMoreAnotherViewModel.Input(reviewBlindButtonTapped: self.selfView.reviewBlindButton.rx.tap, reportButtonTapped: self.selfView.reportButton.rx.tap, allReviewBlindButtonTapped: self.selfView.allReviewBlindButton.rx.tap)
        
        let output = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
}
