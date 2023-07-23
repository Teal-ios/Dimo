//
//  NotificationIDViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import Foundation
import RxSwift
import RxCocoa

final class NotificationIDViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        let pwFindButtonTapped: ControlEvent<Void>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
    }
        
    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }

    func transform(input: Input) -> Output {
        input.pwFindButtonTapped.bind { [weak self]_ in
            self?.coordinator?.showFindPWViewController()
        }.disposed(by: disposeBag)
        
        input.nextButtonTapped.bind { [weak self]_ in
            self?.coordinator?.showLoginStartViewController()
        }.disposed(by: disposeBag)
        return Output()
    }
}
