//
//  JoinTermsViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/29.
//

import Foundation
import RxSwift
import RxCocoa

final class JoinTermsViewModel: ViewModelType {
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input {
        var acceptButtonTapped: ControlEvent<Void>
    }
    struct Output {}
    
    init(coordinator: AuthCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.acceptButtonTapped.bind { [weak self]_ in
            self?.coordinator?.showSignupIdentificationViewController()
        }.disposed(by: disposeBag)
        return Output()
    }
}
