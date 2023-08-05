//
//  DigViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/04.
//

import UIKit
import RxSwift
import RxCocoa

final class DigViewController: BaseViewController {
    
    let selfView = DigView()
    
    private var viewModel: DigViewModel
    
    init(viewModel: DigViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupBinding() {
        let input = DigViewModel.Input(nextButtonTap: self.selfView.nextButton.rx.tap)
        let output = viewModel.transform(input: input)
    }
}
