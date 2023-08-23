//
//  SearchCategoryViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol searchCategoryChangeDelegate {
    func sendCategoryChange(category: SearchCategoryCase)
}

final class SearchCategoryViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?
    
    struct Input{
        let workButtonTapped: ControlEvent<Void>
        let characterButtonTapped: ControlEvent<Void>
        
    }
    
    struct Output{
        let categoryCase: BehaviorRelay<SearchCategoryCase>
    }
    
    init(coordinator: VoteCoordinator?, categoryCase: SearchCategoryCase) {
        self.coordinator = coordinator
        self.categoryCase.accept(categoryCase)
    }
    
    var delegate: searchCategoryChangeDelegate?
    let categoryCase = BehaviorRelay(value: SearchCategoryCase.character)
    
    func transform(input: Input) -> Output {
        input.workButtonTapped
            .withUnretained(self)
            .bind { vm,  _ in
                vm.delegate?.sendCategoryChange(category: SearchCategoryCase.work)
                vm.coordinator?.dismissViewController()
            }.disposed(by: disposeBag)
        
        input.characterButtonTapped
            .withUnretained(self)
            .bind { vm,  _ in
                vm.delegate?.sendCategoryChange(category: SearchCategoryCase.character)
                vm.coordinator?.dismissViewController()
            }.disposed(by: disposeBag)
        
        return Output(categoryCase: self.categoryCase)
    }
}
