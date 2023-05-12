//
//  SendMessageViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/12.
//

import UIKit
import RxCocoa
import RxSwift

final class SendMessageViewController: BaseViewController {
    //MARK: Delegate
    let sendMessageView = SendMessageView()
    
    private var viewModel: SendMessageViewModel
    
    //MARK: Input
    private lazy var input = SendMessageViewModel.Input(returnMessageButtonTapped: sendMessageView.returnMessageButton.rx.tap, nextButtonTapped: sendMessageView.nextButton.rx.tap)
    
    init(viewModel: SendMessageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = sendMessageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
    }
    
}

