//
//  NickNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift
import RxCocoa

class NickNameViewModel: ViewModelType {
    var disposebag: DisposeBag = DisposeBag()
    
    private weak var coordinator: AuthCoordinator?
    private var settingUseCase: SettingUseCase
    var id: String? = ""

    
    struct Input {
        var textFieldInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
        var duplicationButtonTap: ControlEvent<Void>
    }
    struct Output {
        var nickNameValid: Observable<(policy: Bool, repeatCheck:Bool)>
    }
    init(coordinator: AuthCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    func transform(input: Input) -> Output {
        
        // 닉네임 중복확인
        let idNickNameValid = input.textFieldInput.map { str in
            return (policy:str != "태수", repeatCheck: true)
        }
        
        input.textFieldInput.bind { [weak self] id in
            self?.id = id
        }
        .disposed(by: disposebag)
        
        input.duplicationButtonTap
            .flatMapLatest { [weak self] _ in
                (self?.settingUseCase.duplicationNicknameExcute(user_id: UserDefaults.standard.string(forKey: "userId") ?? "", user_nickname: self?.id ?? "")
                    .do(onSuccess: { data in
                        print(data, "data들어옴!!")
                    }, onError: { error in
                        print(error)
                    })
                        .asObservable())!
            }
            .subscribe()
            .disposed(by: disposebag)
        
        return Output(nickNameValid: idNickNameValid)
    }
}
