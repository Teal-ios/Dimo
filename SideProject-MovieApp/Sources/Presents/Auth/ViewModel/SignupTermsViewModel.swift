//
//  SignupTermsViewModel.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import Foundation
import RxSwift
import RxCocoa

final class SignupTermsViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        var acceptButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        var acceptButtonTapped: ControlEvent<Void>
    }
        
    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }

    func transform(input: Input) -> Output {
        input.acceptButtonTapped.bind { [weak self]_ in
            self?.coordinator?.showSignupIdentificationViewController()
        }.disposed(by: disposeBag)
        
        return Output(acceptButtonTapped: input.acceptButtonTapped)
    }
    
}
