//
//  LoginViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit

class LoginViewController: BaseViewController {
    

    //MARK: Delegate
    let loginView = OnBoardingView()

    //MARK: Delegate
    private var viewModel: OnBoardingViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("LoginViewController: fatal error")
    }
    
    init(viewModel: OnBoardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
    }
}
