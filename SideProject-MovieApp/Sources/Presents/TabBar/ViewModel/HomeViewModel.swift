//
//  HomeViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    
    struct Input {
        let categoryButtonTapped: PublishRelay<Void>
        let posterCellSelected: PublishSubject<Void>
    }
    
    struct Output {
        
    }

    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.categoryButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showCategoryViewController()
        }
        .disposed(by: disposebag)
        
        input.posterCellSelected.bind { [weak self] _ in
            self?.coordinator?.showCharacterDetailViewController()
        }
        .disposed(by: disposebag)
        
        return Output()
    }
}
