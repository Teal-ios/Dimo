//
//  MovieDetailRankViewController.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/26.
//

import UIKit
import RxCocoa

class MovieDetailRankViewController: BaseViewController {
    private let selfView = MovieDetailRankView()
    
    private var viewModel: MovieDetailRankViewModel
    
    override func loadView() {
        view = selfView
    }
    
    init(viewModel: MovieDetailRankViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func setupBinding() {
        
        let input = MovieDetailRankViewModel.Input(backgroundButtonTapped: selfView.backgroundButton.rx.tap)
        
        let output = viewModel.transform(input: input)
    }
    
    override func setupAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
}
