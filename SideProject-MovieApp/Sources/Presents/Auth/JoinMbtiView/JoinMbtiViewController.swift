//
//  JoinMbtiViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/06.
//

import UIKit
import RxCocoa

class JoinMbtiViewController: BaseViewController {
    
    let joinMbtiView = JoinMbtiView()
    
    private var viewModel: JoinMbtiViewModel
    
    //MARK: Input
    private lazy var input = JoinMbtiViewModel.Input(findMbtiButtonTapped: joinMbtiView.findMbtiButton.rx.tap, nextButtonTapped: joinMbtiView.nextButton.rx.tap)
    
    override func loadView() {
        view = joinMbtiView
    }
    init(viewModel: JoinMbtiViewModel) {
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
