//
//  IDNickNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/31.
//

import Foundation
import RxSwift
import RxCocoa

class IDNickNameViewModel: ViewModelType {
    var disposebag: DisposeBag = DisposeBag()
    
    private weak var coordinator: AuthCoordinator?
    private var currnetViewCases: CurrentViewCases
    
    struct Input {
        var nextButtonTapped: ControlEvent<Void>
    }
    struct Output {
        
    }
    init(coordinator: AuthCoordinator, currentViewCases: CurrentViewCases) {
        self.coordinator = coordinator
        self.currnetViewCases = currentViewCases
    }
    func transform(input: Input) -> Output {
        input.nextButtonTapped.bind { [weak self] _ in
            switch self?.currnetViewCases {
            case .IDRegister:
                self?.coordinator?.showNickNameViewController()
            case .NickName:
                self?.coordinator?.showPasswordViewController()
            case .Password:
                self?.coordinator?.showPasswordViewController()
            default:
                print("currentView : Password")
            }
            
        }.disposed(by: disposebag)
        return Output()
    }
}

enum CurrentViewCases {
    case IDRegister, NickName, Password
    
}
