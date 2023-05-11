//
//  JoinCompleteViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import UIKit
import RxCocoa

class JoinCompleteViewController: BaseViewController {
    
    let joinCompleteView = JoinCompleteView()
    
    private var viewModel: JoinCompleteViewModel
    
    //MARK: Input
    private lazy var input = JoinCompleteViewModel.Input(dimoStartButtonTapped: joinCompleteView.dimoStartButton.rx.tap)
    
    override func loadView() {
        view = joinCompleteView
    }
    init(viewModel: JoinCompleteViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
    }
    
}
