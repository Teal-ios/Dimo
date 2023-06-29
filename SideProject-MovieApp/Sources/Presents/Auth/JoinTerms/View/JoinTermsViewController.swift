//
//  JoinTermsViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/29.
//

import UIKit
import RxCocoa

class JoinTermsViewController: BaseViewController {
    

    //MARK: Delegate
    let selfView = JoinTermsView()

    //MARK: Delegate
    private var viewModel: JoinTermsViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: JoinTermsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        print("check")
    }
    override func setupBinding() {
        let input = JoinTermsViewModel.Input(acceptButtonTapped: selfView.acceptButton.rx.tap)
        let _ = viewModel.transform(input: input)
    }
}

