//
//  LoginStartViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

import UIKit

class LoginStartViewController: BaseViewController {

    //MARK: Delegate
    let loginStartView = LoginStartView()

    //MARK: Delegate
    private var viewModel: LoginStartViewModel

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
}
