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
        let currentPasswordTextFieldBenginEditing: ControlEvent<Void>
        let currentPassWordTextFieldText: ControlProperty<String?>
        let newPasswordTextFieldTextBeginEditing: ControlEvent<Void>
        let newPasswordTextFieldText: ControlProperty<String?>
        let newPasswordCheckTextFieldTextBeginEditing: ControlEvent<Void>
        let newPasswordCheckTextFieldText: ControlProperty<String?>
        let passwordChangeButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let isChanged: BehaviorRelay<Bool>
        let isSameWithCurrentPassword: BehaviorRelay<Bool>
        let isSameWithNewPassword: Observable<Bool>
        let isValidPasswordFormat: Observable<Bool>
        let isEmptyNewPasswordCheckTextField: Observable<Bool>
        let newPasswordIsSameWithCurrentPassword: BehaviorRelay<Bool>
        let currentPasswordTextFieldText: BehaviorRelay<String?>
        let newPasswordTextFieldText: BehaviorRelay<String?>
        let newPasswordCheckTextFieldText: BehaviorRelay<String?>
        let isChangeable: BehaviorRelay<(Bool?, Bool?)>
    }
    
    var isSocialLogin: Bool? {
        return UserDefaultManager.isSocialLogin
    }
    
    private var currentPasswordTextFieldText = BehaviorRelay<String?>(value: nil)
    private var newPasswordIsSameWithCurrentPassword = BehaviorRelay<Bool>(value: false)
    private var isSameWithCurrentPassword = BehaviorRelay<Bool>(value: true)
    private var newPasswordTextFieldText = BehaviorRelay<String?>(value: nil)
    private var isValidPasswordFormat = BehaviorRelay<Bool?>(value: nil)
    private var isSameWithNewPassword = BehaviorRelay<Bool?>(value: nil)
    private var changeButtonTapped = PublishRelay<(Bool, Bool)>()
    private var isChangeable = BehaviorRelay<(Bool?, Bool?)>(value: (nil, nil))
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
            .share()
        
        let currentPasswordTextFieldText = BehaviorRelay<String?>(value: "")
        let newPasswordTextFieldText = BehaviorRelay<String?>(value: "")
        let newPasswordCheckTextFieldText = BehaviorRelay<String?>(value: "")
        
        input.currentPasswordTextFieldBenginEditing
            .withUnretained(self)
            .bind { (vm, _) in
                currentPasswordTextFieldText.accept("")
            }
            .disposed(by: disposeBag)
        
        input.newPasswordTextFieldTextBeginEditing
            .withUnretained(self)
            .bind { (vm, _) in
                newPasswordTextFieldText.accept("")
            }
            .disposed(by: disposeBag)
        
        input.newPasswordCheckTextFieldTextBeginEditing
            .withUnretained(self)
            .bind { (vm, _) in
                newPasswordCheckTextFieldText.accept("")
            }
            .disposed(by: disposeBag)
        
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
                                    .share()
        
        isSameWithNewPassword
            .bind { [weak self] isSame in
                guard let self else { return }
                self.isSameWithNewPassword.accept(isSame)
                self.isChangeable.accept((self.isValidPasswordFormat.value, self.isSameWithNewPassword.value))
            }
            .disposed(by: disposeBag)
        
        isValidPasswordFormat
            .bind { [weak self] isValid in
                guard let self else { return }
                self.isValidPasswordFormat.accept(isValid)
                self.isChangeable.accept((self.isValidPasswordFormat.value, self.isSameWithNewPassword.value))
            }
            .disposed(by: disposeBag)
        
        let isEmptyNewPasswordCheckTextField = input.newPasswordTextFieldText
            .orEmpty
            .map { $0.count == 0 }
        
        input.passwordChangeButtonTapped
            .bind { [weak self] in
                guard let self else { return }
                
                isValidPasswordFormat.bind(to: self.isValidPasswordFormat)
                    .disposed(by: self.disposeBag)

                self.loadPasswordChange()
            }
            .disposed(by: disposeBag)
        
        return Output(isChanged: isChanged,
                      isSameWithCurrentPassword: self.isSameWithCurrentPassword,
                      isSameWithNewPassword: isSameWithNewPassword,
                      isValidPasswordFormat: isValidPasswordFormat,
                      isEmptyNewPasswordCheckTextField: isEmptyNewPasswordCheckTextField,
                      newPasswordIsSameWithCurrentPassword: self.newPasswordIsSameWithCurrentPassword,
                      currentPasswordTextFieldText: currentPasswordTextFieldText,
                      newPasswordTextFieldText: newPasswordTextFieldText,
                      newPasswordCheckTextFieldText: newPasswordCheckTextFieldText,
                      isChangeable: self.isChangeable)
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
            } else if passwordChange.code == 402 {
                isSameWithCurrentPassword.accept(true)
                newPasswordIsSameWithCurrentPassword.accept(true)
            }
        }
    }
}
