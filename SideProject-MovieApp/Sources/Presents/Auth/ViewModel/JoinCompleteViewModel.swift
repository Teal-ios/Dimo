//
//  JoinCompleteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import Foundation
import RxSwift
import RxCocoa

final class JoinCompleteViewModel: ViewModelType {
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    
    struct Input{
        let dimoStartButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
    }
    
    func transform(input: Input) -> Output {
        input.dimoStartButtonTapped.bind { [weak self] _ in
            self?.coordinator?.connectHomeTabBarCoordinator()
        }.disposed(by: disposebag)
        return Output()
    }
    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }
}
