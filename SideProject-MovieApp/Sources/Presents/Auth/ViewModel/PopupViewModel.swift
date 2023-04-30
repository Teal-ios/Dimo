//
//  PopupViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/29.
//

import Foundation
import RxSwift
import RxCocoa

class PopupViewModel: ViewModelType {
    
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        let okButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
    }
    
    init(coordinator: AuthCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.okButtonTapped.bind { [weak self] _ in
            self?.coordinator?.popPopupViewController()
            print("이게 찍혀야하는데")
        }.disposed(by: disposebag)
        return Output()
    }
}
