//
//  ErrorNotFoundViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/04.
//

import Foundation
import RxSwift
import RxCocoa

final class ErrorNotFoundViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    
    struct Input{
        let retryButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
    }
    
    func transform(input: Input) -> Output {
        input.retryButtonTapped.bind { [weak self] _ in
            self?.coordinator?.popPopupViewController()
        }.disposed(by: disposeBag)
        return Output()
    }
    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }
}
