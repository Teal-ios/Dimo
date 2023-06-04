//
//  WithDrawViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import UIKit
import SnapKit

final class WithDrawViewController: BaseViewController {
    
    let selfView = WithDrawView()
    
    private var viewModel: WithDrawViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("WithDrawViewController: fatal error")
    }
    
    init(viewModel: WithDrawViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
