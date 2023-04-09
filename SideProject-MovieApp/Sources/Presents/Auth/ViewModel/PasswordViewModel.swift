//
//  PasswordViewModel.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/04/02.
//

import Foundation
import RxCocoa
import RxSwift

class PasswordViewModel: ViewModelType {
    var disposebag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    struct Input {
        
    }
    struct Output {
        
    }
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    func transform(input: Input) -> Output {
        return Output()
    }
}
