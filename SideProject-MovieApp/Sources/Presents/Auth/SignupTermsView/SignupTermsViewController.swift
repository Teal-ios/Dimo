//
//  SignupTermsViewController.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import UIKit

class SignupTermsViewController: BaseViewController {
    

    //MARK: Delegate
    let signupTermsView = SignupTermsView()

    //MARK: Delegate
    private var viewModel: SignupTermsViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: SignupTermsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = signupTermsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        print("check")
    }

}

