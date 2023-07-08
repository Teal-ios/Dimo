//
//  VoteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import Foundation
import RxSwift
import RxCocoa

final class VoteViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?

    init(coordinator: VoteCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input{
        let characterRandomRecommandCellTapped: PublishSubject<Void>
        let characterSearchCellTapped: PublishSubject<Void>
    }
    
    struct Output{
    }
    
    
    func transform(input: Input) -> Output {
        input.characterRandomRecommandCellTapped.bind { [weak self] _ in
            guard let self else { return }
            print("이건울리니")
            self.coordinator?.showSearchViewController()
        }
        .disposed(by: disposeBag)
        
        input.characterSearchCellTapped.bind { [weak self] _ in
            guard let self else { return }
            print("이건울리니")
            self.coordinator?.showSearchViewController()
        }
        .disposed(by: disposeBag)
        
        return Output()
    }
}
