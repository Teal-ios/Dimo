//
//  CategoryViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import RxCocoa

class CategoryViewController: BaseViewController {
    private let categoryView = CategoryView()
    
    private var viewModel: CategoryViewModel
    override func loadView() {
        view = categoryView
    }
    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        
        let input = CategoryViewModel.Input(movieButtonTapped: categoryView.movieButton.rx.tap, dramaButtonTapped: categoryView.dramaButton.rx.tap)
        
        let output = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        categoryView.backgroundColor = .clear
    }
    
}
