//
//  MainView.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import UIKit

class OnBoardingViewController: BaseViewController {
    

    //MARK: Delegate
    let onBoardingView = OnBoardingView()

    //MARK: Delegate
    private var viewModel: OnBoardingViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("GenderViewController: fatal error")
    }
    
    init(viewModel: OnBoardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = onBoardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
    }
}
