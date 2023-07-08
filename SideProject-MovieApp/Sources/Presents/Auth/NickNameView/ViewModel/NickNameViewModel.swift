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
            .bind { [weak self] _ in
                guard let self else { return }
                guard let userId = UserDefaults.standard.string(forKey: "userId") else { return }
                guard let nickname = nickname else { return }
                self.duplicationNicknameCheck(user_id: userId, user_nickname: nickname)
                self.duplicationNicknameCheck(user_id: userId, user_nickname: nickname)
            }
            .disposed(by: disposeBag)
        
        return Output(nicknameValid: isValidNickname, nextButtonValid: self.duplicationValid)
    }
}

extension NickNameViewModel {
    
    private func duplicationNicknameCheck(user_id: String, user_nickname: String) {
        
        let query = NicknameDuplicationQuery(user_id: user_id, user_nickname: user_nickname)
        Task {
            let duplicationNickname = try await settingUseCase.executeNicknameDuplication(query: query)
            print("🔥", duplicationNickname)
            if duplicationNickname.code == 200 {
                duplicationValid.accept(true)
            }
        }
    }
}
