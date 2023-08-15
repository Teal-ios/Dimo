//
//  MovieDetailEvaluateViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailEvaluateViewController: BaseViewController {
    private let selfView = MovieDetailEvaluateView()
    
    private var viewModel: MovieDetailEvaluateViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: MovieDetailEvaluateViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        
        let input = MovieDetailEvaluateViewModel.Input(backgroundButtonTapped: selfView.backgroundButton.rx.tap, goodButtonTapped: selfView.goodChoiceButton.rx.tap, badButtonTapped: selfView.badChoiceButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.evaluateValid
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { vc, bool in
                guard let bool else { return }
                switch bool {
                    
                case true:
                    vc.selfView.updateGoodButtonUI(isSelect: true)
                    vc.selfView.updateBadButtonUI(isSelect: false)
                case false:
                    vc.selfView.updateGoodButtonUI(isSelect: false)
                    vc.selfView.updateBadButtonUI(isSelect: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
}
