//
//  ErrorNotFoundViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/04.
//

import UIKit
import RxCocoa

class ErrorNotFoundViewController: BaseViewController {
    
    let selfView = ErrorNotFoundView()
    
    private var viewModel: ErrorNotFoundViewModel
    
    //MARK: Input
    private lazy var input = ErrorNotFoundViewModel.Input(retryButtonTapped: selfView.retryButton.rx.tap)
    
    override func loadView() {
        view = selfView
    }
    init(viewModel: ErrorNotFoundViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false

    }
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
    }
}
