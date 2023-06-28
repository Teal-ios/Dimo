//
//  EditUserNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift
import RxCocoa

final class EditNicknameViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private var settingUseCase: SettingUseCase
    private weak var coordinator: SettingCoordinator?
    private var nickname: String?
    
    struct Input {
        var textFieldEdited: ControlProperty<String?>
        var nicknameDuplicationButtonTapped: ControlEvent<Void>
        var nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        var isValidNickname: Observable<(isValidNicknameFormat: Bool, isDuplicated: Bool)>
    }
    
    init(coordinator: SettingCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
        input.nextButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showAlertEditUserNameViewController()
        }.disposed(by: disposeBag)
        
        let isValidNickname = input.textFieldEdited.orEmpty.map { str in
            str.count > 2
        }
        
        input.textFieldEdited
            .bind { [weak self] nickname in
                self?.nickname = nickname
            }
            .disposed(by: disposeBag)
        
        input.nicknameDuplicationButtonTapped
            .bind(onNext: {
                guard let userId = UserDefaults.standard.string(forKey: "userId"),
                      let nickname = self.nickname else { return }
                let query = NicknameDuplicationQuery(user_id: userId, user_nickname: nickname)
                let nicknameDuplicationObservable = self.settingUseCase.executeNicknameDuplication(query: query)
                
                nicknameDuplicationObservable.bind { [weak self] isDuplicatedNickname in
                    print("🔥", isDuplicatedNickname)
                }
            })
            .disposed(by: disposeBag)
        
        let idNickNameValid = input.textFieldEdited.map { str in
            return (isValidNicknameFormat: true, isDuplicated:str != "태수")
        }
        
        return Output(isValidNickname: idNickNameValid)
    }
}
