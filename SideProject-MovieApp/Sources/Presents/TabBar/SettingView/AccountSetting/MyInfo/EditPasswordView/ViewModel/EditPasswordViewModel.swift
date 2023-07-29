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
        let isSameWithCurrentPassword: BehaviorRelay<Bool?>
        let passwordChageButtonTappedOutput: PublishRelay<(Bool, Bool)>
    }
    
    private var currentPasswordTextFieldText = BehaviorRelay<String?>(value: nil)
    private var isSameWithCurrentPassword = BehaviorRelay<Bool?>(value: nil)
    private var newPasswordTextFieldText = BehaviorRelay<String?>(value: nil)
    private var isValidPasswordFormat = BehaviorRelay<Bool?>(value: nil)
    private var isSameWithNewPassword = BehaviorRelay<Bool?>(value: nil)
    private var changeButtonTapped = PublishRelay<(Bool, Bool)>()
    private var isChanged = BehaviorRelay<Bool>(value: false)
    
    init(coordinator: SettingCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$])[A-Za-z\\d!@#$]{8,16}$"
        
        let isValidPasswordFormat = input.newPasswordTextFieldText
            .orEmpty
            .map {  NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: $0) }
        
        input.currentPassWordTextFieldText
            .bind { [weak self] text in
                guard let self else { return }
                self.currentPasswordTextFieldText.accept(text)
            }
            .disposed(by: disposeBag)
        
        input.newPasswordTextFieldText
            .bind(onNext: { [weak self] text in
                self?.newPasswordTextFieldText.accept(text)
            })
            .disposed(by: disposeBag)
        
        let isSameWithNewPassword = Observable.combineLatest(input.newPasswordTextFieldText.orEmpty, input.newPasswordCheckTextFieldText.orEmpty)
                                    .map { $0 == $1}
        
        input.passwordChangeButtonTapped
            .bind { [weak self] in
                guard let self else { return }
                
                isValidPasswordFormat.bind(to: self.isValidPasswordFormat)
                    .disposed(by: self.disposeBag)
                isSameWithNewPassword.bind(to: self.isSameWithNewPassword)
                    .disposed(by: self.disposeBag)
                
                guard let isSameWithNewPassword = self.isSameWithNewPassword.value else { return }
                guard let isValidPasswordFormat = self.isValidPasswordFormat.value else { return }
                
                self.changeButtonTapped.accept((isValidPasswordFormat,
                                                isSameWithNewPassword))
                
                guard isValidPasswordFormat && isSameWithNewPassword  else { return }
                self.loadPasswordChange()
            }
            .disposed(by: disposeBag)
        
//        isSameWithCurrentPassword.bind { bool in
//            if bool == true {
//                self.isChanged.accept(true)
//            }
//        }
//        .disposed(by: disposeBag)
        
        return Output(isChanged: isChanged,
                      isSameWithCurrentPassword: self.isSameWithCurrentPassword, passwordChageButtonTappedOutput: self.changeButtonTapped)
    }
}

extension EditPasswordViewModel {
    
    private func loadPasswordChange() {
        guard let userId = UserDefaultManager.userId,
              let currentPassword = currentPasswordTextFieldText.value,
              let newPassword = self.newPasswordTextFieldText.value else { return }
              
        let query = PasswordChangeQuery(user_id: userId, currentPassword: currentPassword, newPassword: newPassword)
        
        Task {
            let passwordChange = try await settingUseCase.executePasswordChange(query: query)

            if passwordChange.code == 200 {
                isSameWithCurrentPassword.accept(true)
                isChanged.accept(true)
                UserDefaultManager.password = newPassword
            } else if passwordChange.code == 401 {
                isSameWithCurrentPassword.accept(false)
                isChanged.accept(false)
            } else {
                isChanged.accept(false)
            }
        }
    }
}
