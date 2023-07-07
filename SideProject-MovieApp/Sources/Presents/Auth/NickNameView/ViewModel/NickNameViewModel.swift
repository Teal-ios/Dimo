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
    var disposeBag: DisposeBag = DisposeBag()
    
    private weak var coordinator: AuthCoordinator?
    private var settingUseCase: SettingUseCase
    private var nickname: String?
    private var duplicationValid = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        var textFieldInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
        var duplicationButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        var nicknameValid: Observable<Bool>
        var nextButtonValid: BehaviorRelay<Bool>
    }
    
    init(coordinator: AuthCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
        input.nextButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showPasswordViewController()
        }.disposed(by: disposeBag)
        // 닉네임 중복확인
        let isValidNickname = input.textFieldInput.orEmpty.map { str in
            str.count > 2
        }
        
        input.textFieldInput.bind { [weak self] nickname in
            self?.nickname = nickname
        }
        .disposed(by: disposeBag)
        
        input.duplicationButtonTap
            .bind(onNext: {
//                guard let userId = UserDefaults.standard.string(forKey: "userId"),
//                      let userNickname = self.nickname else { return }
//                let query = NicknameDuplicationQuery(user_id: userId, user_nickname: userNickname)
//                let nicknameDuplicationObservable = self.settingUseCase.executeNicknameDuplication(query: query)
//                
//                nicknameDuplicationObservable.bind { [weak self] data  in
//                    print(data, "데이터 드러옴")
//                    self?.duplicationValid.accept(true)
//                }
            })
            .disposed(by: disposeBag)
        
        return Output(nicknameValid: isValidNickname, nextButtonValid: self.duplicationValid)
    }
}
