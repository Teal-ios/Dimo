//
//  DigViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/04.
//

import Foundation
import RxSwift
import RxCocoa

final class DigViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?
    private var voteUseCase: VoteUseCase

    init(coordinator: VoteCoordinator?, voteUseCase: VoteUseCase) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
    }
    
    struct Input{
        let nextButtonTap: ControlEvent<Void>
    }
    
    struct Output{
    }
    

    
    func transform(input: Input) -> Output {
        input.nextButtonTap
            .withUnretained(self)
            .bind { vm, _ in
                vm.coordinator?.showVoteCompleteViewController()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
