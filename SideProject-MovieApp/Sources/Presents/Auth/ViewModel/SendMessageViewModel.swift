//
//  SendMessageViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/12.
//

import Foundation
import RxSwift
import RxCocoa

final class SendMessageViewModel: ViewModelType {

    var disposebag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        let returnMessageButtonTapped: ControlEvent<Void>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
    }
        
    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }

    func transform(input: Input) -> Output {
        input.returnMessageButtonTapped.bind { [weak self]_ in
            print("message 다시 받는 로직 추가")
        }.disposed(by: disposebag)
        
        input.nextButtonTapped.bind { [weak self]_ in
            self?.coordinator?.showLoginStartViewController()
        }.disposed(by: disposebag)
        return Output()
    }
}
