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
        let isChanged: BehaviorRelay<Bool>
        let passwordChageButtonTappedOutput: PublishRelay<(Bool, Bool, Bool)>
    }
    
    private var newPasswordTextFieldText = BehaviorRelay<String?>(value: "")
    private var isSameWithExistingPassword = BehaviorRelay<Bool?>(value: nil)
    private var isValidPasswordFormat = BehaviorRelay<Bool?>(value: nil)
    private var isSameWithNewPassword = BehaviorRelay<Bool?>(value: nil)
    private var changeButtonTapped = PublishRelay<(Bool, Bool, Bool)>()
    private var isChanged = BehaviorRelay<Bool>(value: false)
    
    init(coordinator: SettingCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$])[A-Za-z\\d!@#$]{8,16}$"
        
        let isSameWithExistingPassword = input.currentPassWordTextFieldText
            .orEmpty
            .map { $0 == UserDefaultManager.password }
        
        let isValidPasswordFormat = input.newPasswordTextFieldText
            .orEmpty
            .map {  NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: $0) }
        
        input.newPasswordTextFieldText
            .bind(to: self.newPasswordTextFieldText)
            .disposed(by: disposeBag)
        
        let isSameWithNewPassword = Observable.combineLatest(input.newPasswordTextFieldText.orEmpty, input.newPasswordCheckTextFieldText.orEmpty)
                                    .map { $0 == $1}
        
        input.passwordChangeButtonTapped
            .bind { [weak self] in
                guard let self else { return }
                
                isSameWithExistingPassword.bind(to: self.isSameWithExistingPassword)
                    .disposed(by: self.disposeBag)
                isValidPasswordFormat.bind(to: self.isValidPasswordFormat)
                    .disposed(by: self.disposeBag)
                isSameWithNewPassword.bind(to: self.isSameWithNewPassword)
                    .disposed(by: self.disposeBag)
                
                guard let isSameWithExistingPassword = self.isSameWithExistingPassword.value else { return }
                guard let isSameWithNewPassword = self.isSameWithNewPassword.value else { return }
                guard let isValidPasswordFormat = self.isValidPasswordFormat.value else { return }
                
                self.changeButtonTapped.accept((isSameWithExistingPassword,
                                                isValidPasswordFormat,
                                                isSameWithNewPassword))
                self.loadPasswordChange()
            }
            .disposed(by: disposeBag)
        
        return Output(isChanged: isChanged, passwordChageButtonTappedOutput: self.changeButtonTapped)
    }
}

extension EditPasswordViewModel {
    
    private func loadPasswordChange() {
        guard let userId = UserDefaultManager.userId,
              let currentPassword = UserDefaultManager.password,
              let newPassword = self.newPasswordTextFieldText.value else { return }
              
        let query = PasswordChangeQuery(user_id: userId, currentPassword: currentPassword, newPassword: newPassword)
        
        Task {
            let passwordChange = try await settingUseCase.executePasswordChange(query: query)
            print("🔥 PASSWORD CHANGE: ", passwordChange)
            
            if passwordChange.code == 200 {
                isChanged.accept(true)
                UserDefaultManager.password = newPassword
            } else if passwordChange.code == 401 {
                isSameWithNewPassword.accept(false)
                isChanged.accept(false)
            } else {
                isChanged.accept(false)
            }
        }
    }
}
