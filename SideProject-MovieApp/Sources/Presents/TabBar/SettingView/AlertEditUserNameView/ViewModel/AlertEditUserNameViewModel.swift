//
//  AlertEditUserNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift
import RxCocoa

final class AlertEditUserNameViewModel: ViewModelType {
    var disposeBag: DisposeBag = DisposeBag()
    
    private weak var coordinator: SettingCoordinator?
    
    struct Input {
        var cancelButtonTapped: ControlEvent<Void>
        var okButtonTapped: ControlEvent<Void>
    }
    struct Output {
    }
    init(coordinator: SettingCoordinator?) {
        self.coordinator = coordinator
    }
    func transform(input: Input) -> Output {
        input.cancelButtonTapped.bind { [weak self] _ in
            print("아니요")
            
        }.disposed(by: disposeBag)
        
        input.okButtonTapped.bind { [weak self] _ in
            print("변경하기")
        }
        .disposed(by: disposeBag)

        
        return Output()
    }
}
