//
//  EditUserNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift
import RxCocoa

final class EditUserNameViewModel: ViewModelType {
    var disposebag: DisposeBag = DisposeBag()
    
    private weak var coordinator: SettingCoordinator?
    
    struct Input {
        var textFieldInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
    }
    struct Output {
        var idNickNameValid: Observable<(policy: Bool, repeatCheck:Bool)>
    }
    init(coordinator: SettingCoordinator) {
        self.coordinator = coordinator
    }
    func transform(input: Input) -> Output {
        input.nextButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showAlertEditUserNameViewController()
            
        }.disposed(by: disposebag)
        // 닉네임 중복확인
        let idNickNameValid = input.textFieldInput.map { str in
            return (policy:str != "태수", repeatCheck: true)
        }
        
        return Output(idNickNameValid: idNickNameValid)
    }
}
