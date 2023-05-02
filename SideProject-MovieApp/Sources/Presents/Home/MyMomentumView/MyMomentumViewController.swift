//
//  MyMomentumViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import UIKit

class MyMomentumViewController: BaseViewController {
    let voteView = MyMomentumView()
    
    private var viewModel: MyMomentumViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("MyMomentumViewController: fatal error")
    }
    
    init(viewModel: MyMomentumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

}
