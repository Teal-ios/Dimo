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
        
        
    }
    
}
