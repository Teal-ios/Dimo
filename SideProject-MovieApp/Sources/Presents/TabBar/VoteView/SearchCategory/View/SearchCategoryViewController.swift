//
//  SearchCategoryViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/23.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchCategoryViewController: BaseViewController {
    private let selfView = SearchCategoryView()
    
    private var viewModel: SearchCategoryViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: SearchCategoryViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        
        let input = SearchCategoryViewModel.Input(workButtonTapped: selfView.selfView.movieButton.rx.tap, characterButtonTapped: selfView.selfView.animationButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.categoryCase
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, categoryCase in
                vc.selfView.configureCategoryCase(category: categoryCase)
            }
            .disposed(by: disposeBag)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
}
