//
//  EditPasswordViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxCocoa
import RxSwift

class EditPasswordViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private weak var coordinator: SettingCoordinator?
    private var settingUseCase: SettingUseCase
    
    struct Input {
        let currentPassWordTextFieldText: ControlProperty<String?>
        let newPasswordTextFieldText: ControlProperty<String?>
        let newPasswordCheckTextFieldText: ControlProperty<String?>
        let passwordChangeButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let isSameWithExistingPassword: BehaviorRelay<Bool>
        let isValidPasswordFormat: BehaviorRelay<Bool>
        let isSameWithNewPassword: BehaviorRelay<Bool>
        let isChanged: BehaviorRelay<Bool>
    }
    
    private var newPasswordTextFieldText = BehaviorRelay<String?>(value: "")
    private var isSameWithExistingPassword = BehaviorRelay<Bool>(value: false)
    private var isValidPasswordFormat = BehaviorRelay<Bool>(value: false)
    private var isSameWithNewPassword = BehaviorRelay<Bool>(value: false)
    private var isChanged = BehaviorRelay<Bool>(value: false)
    
    init(coordinator: SettingCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
//        let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$])[A-Za-z\\d!@#$]{8,16}$"
        
        input.currentPassWordTextFieldText
            .orEmpty
            .bind(onNext: { [weak self] text in
                guard let self else { return }
                guard let existingPassword = UserDefaultManager.password else { return }
                if text == existingPassword {
                    self.isSameWithExistingPassword.accept(true)
                }
            })
            .disposed(by: disposeBag)
        
        input.newPasswordTextFieldText
            .orEmpty
            .map { $0.count >= 8 && $0.count <= 16}
//            .map {  NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: $0) }
            .bind(to: isValidPasswordFormat)
            .disposed(by: disposeBag)
        
        input.newPasswordTextFieldText
            .orEmpty
            .bind(to: newPasswordTextFieldText)
            .disposed(by: disposeBag)
        
        input.newPasswordCheckTextFieldText
            .orEmpty
            .bind { [weak self] text in
                guard let self else { return }
                if text == self.newPasswordTextFieldText.value {
                    self.isSameWithNewPassword.accept(true)
                }
            }
            .disposed(by: disposeBag)
        
        input.passwordChangeButtonTapped
            .bind { [weak self] in
                guard let self else { return }
                self.loadPasswordChange()
            }
            .disposed(by: disposeBag)

        return Output(isSameWithExistingPassword: isSameWithExistingPassword,
                      isValidPasswordFormat: isValidPasswordFormat,
                      isSameWithNewPassword: isSameWithNewPassword,
                      isChanged: isChanged)
    }
}

extension EditPasswordViewModel {
    
    private func loadPasswordChange() {
        guard isSameWithExistingPassword.value,
              isValidPasswordFormat.value,
              isSameWithNewPassword.value else { return }
        
        guard let userId = UserDefaultManager.userId,
              let currentPassword = UserDefaultManager.password,
              let newPassword = self.newPasswordTextFieldText.value else { return }
              
        let query = PasswordChangeQuery(user_id: userId, currentPassword: currentPassword, newPassword: newPassword)
        
        Task {
            let passwordChange = try await settingUseCase.executePasswordChange(query: query)
            if passwordChange.code == 200 {
                isChanged.accept(true)
            } else {
                isChanged.accept(false)
            }
        }
    }
}
