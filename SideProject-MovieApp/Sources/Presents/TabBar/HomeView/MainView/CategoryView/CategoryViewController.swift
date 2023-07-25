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
    
    let category = BehaviorRelay(value: "")
    
    override func setupBinding() {
        
        let input = CategoryViewModel.Input(movieButtonTapped: categoryView.movieButton.rx.tap, dramaButtonTapped: categoryView.animationButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.category.bind { [weak self] category in
            guard let self else { return }
            self.category.accept(category)
        }
        .disposed(by: self.disposeBag)
        
        category.bind { [weak self] category in
            guard let self else { return }
            self.categoryView.updateCategory(category: category)
        }
        .disposed(by: disposeBag)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        categoryView.backgroundColor = .clear
    }
}
