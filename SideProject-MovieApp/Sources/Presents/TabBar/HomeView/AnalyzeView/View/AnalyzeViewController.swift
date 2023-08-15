//
//  AnalyzeViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/14.
//

import UIKit

final class AnalyzeViewController: BaseViewController {
    
    let selfView = AnalyzeView()
    
    private var viewModel: AnalyzeViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("FeedViewController: fatal error")
    }
    
    init(viewModel: AnalyzeViewModel) {
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
