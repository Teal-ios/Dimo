//
//  CategoryViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import UIKit
import RxCocoa

protocol SendCategoryDelegate {
    func sendCategory(category: String)
}

class CategoryViewController: BaseViewController {
    private let categoryView = CategoryView()
    
    private var viewModel: CategoryViewModel
    
    var delegate: SendCategoryDelegate?
    
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
        
        output.dramaButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            delegate?.sendCategory(category: self.categoryView.animationLabel.text ?? "애니")
            print("애니 버튼 클릭 및 델리게이트 전달 완료")
        }
        .disposed(by: disposeBag)
        
        output.movieButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            delegate?.sendCategory(category: self.categoryView.movieLabel.text ?? "영화")
            print("영화 버튼 클릭 및 델리게이트 전달 완료")
        }
        .disposed(by: disposeBag)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        categoryView.backgroundColor = .clear
    }
    
}
