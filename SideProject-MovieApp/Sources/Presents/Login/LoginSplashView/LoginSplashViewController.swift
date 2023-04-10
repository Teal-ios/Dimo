//
//  LoginSplashViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/09.
//

import UIKit

class LoginSplashViewController: BaseViewController {

    //MARK: Delegate
    let loginSplashView = LoginSplashView()

    //MARK: Delegate
    private var viewModel: LoginSplashViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("LoginSplashViewController: fatal error")
    }
    
    init(viewModel: LoginSplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = loginSplashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //2초있다가 로그인 화면으로!!
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: viewModel.presentLoginStartViewController)
    }
}
