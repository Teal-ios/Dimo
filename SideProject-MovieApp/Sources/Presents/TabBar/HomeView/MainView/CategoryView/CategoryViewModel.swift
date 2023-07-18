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
    private var category: BehaviorRelay<String>
    
    struct Input{
        let movieButtonTapped: ControlEvent<Void>
        let dramaButtonTapped: ControlEvent<Void>

    }
    
    struct Output{
        let category: BehaviorRelay<String>

    }
    
    init(coordinator: HomeCoordinator? = nil, category: String) {
        self.coordinator = coordinator
        self.category = BehaviorRelay(value: category)
    }
    
    func transform(input: Input) -> Output {
        input.movieButtonTapped.bind { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }.disposed(by: disposeBag)
        
        input.dramaButtonTapped.bind { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }.disposed(by: disposeBag)
        return Output(category: self.category)
    }
}
