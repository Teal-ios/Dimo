//
//  LoginStartViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

import UIKit
import RxCocoa

class LoginStartViewController: BaseViewController {
    
    //MARK: Delegate
    let loginStartView = LoginStartView()
    
    //MARK: Delegate
    private var viewModel: LoginStartViewModel
    
    private lazy var input = LoginStartViewModel.Input(dimoLoginButtonTapped: self.loginStartView.dimoLoginButton.rx.tap, signupButtonTapped: self.loginStartView.signupButton.rx.tap)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("LoginStartViewController: fatal error")
    }
    
    init(viewModel: LoginStartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func loadView() {
        view = loginStartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
    }
    
    override func setupBinding() {
        let output = viewModel.transform(input: input)
        
    }
    
}



