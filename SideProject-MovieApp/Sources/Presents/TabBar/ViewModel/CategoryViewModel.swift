//
//  CategoryViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import Foundation
import RxSwift
import RxCocoa

class CategoryViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    
    struct Input{
        let movieButtonTapped: ControlEvent<Void>
        let dramaButtonTapped: ControlEvent<Void>

    }
    
    struct Output{
    }
    
    init(coordinator: HomeCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.movieButtonTapped.bind { [weak self] _ in
            self?.coordinator?.dismissCategoryViewController()
        }.disposed(by: disposeBag)
        
        input.dramaButtonTapped.bind { [weak self] _ in
            self?.coordinator?.dismissCategoryViewController()
        }.disposed(by: disposeBag)
        return Output()
    }
}
