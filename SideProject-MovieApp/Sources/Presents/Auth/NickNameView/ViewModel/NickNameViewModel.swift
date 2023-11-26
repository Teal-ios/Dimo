//
//  NickNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift
import RxCocoa

final class NicknameViewModel: ViewModelType {
        
    var disposeBag: DisposeBag = DisposeBag()
    private var settingUseCase: SettingUseCase
    private weak var coordinator: AuthCoordinator?
    private let signUpFlow: AuthCoordinator.SignUpFlow
    
    struct Input {
        var textFieldEditingDidBegin: ControlEvent<Void>
        var textFieldEditingChanged: ControlEvent<Void>
        var textFieldEditingDidEnd: ControlEvent<Void>
        var textFieldInput: ControlProperty<String?>
        var didTappedNextButton: ControlEvent<Void>
    }
    
    struct Output {
        var isTextFieldEditingDidBegin: BehaviorRelay<Bool>
        var isTextFieldEditingChanged: BehaviorRelay<Bool>
        var isDuplicatedNickname: BehaviorRelay<Bool>
        var isTextFieldChanged: BehaviorRelay<Bool>
    }
    
    private var nickname: String?
    private var isDuplicatedNickname = BehaviorRelay<Bool>(value: true)
    private var isTextFielEditingDidBegin = BehaviorRelay<Bool>(value: false)
    private var isTextFieldChanged = BehaviorRelay<Bool>(value: false)
    private var isTextFieldEditingChanged = BehaviorRelay<Bool>(value: false)
    
    init(coordinator: AuthCoordinator, settingUseCase: SettingUseCase, signUpFlow: AuthCoordinator.SignUpFlow) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
        self.signUpFlow = signUpFlow
    }
    
    func transform(input: Input) -> Output {
        input.textFieldInput
            .do(onNext: { [weak self] text  in
                guard let text = text else { return }
                self?.nickname = text
                if text.count < 2 {
                    self?.isTextFieldEditingChanged.accept(false)
                } else {
                    self?.isTextFieldEditingChanged.accept(true)
                }
            })
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .map { ($0?.count ?? 0) >= 2 }
            .bind { [weak self] isOverTwoCharacter in
                if isOverTwoCharacter {
                    self?.loadNicknameDuplication()
                }
            }
            .disposed(by: disposeBag)
        
        input.textFieldEditingChanged
            .bind { [weak self] in
                self?.isTextFieldChanged.accept(true)
            }
            .disposed(by: disposeBag)
            
        input.didTappedNextButton
            .withUnretained(self)
            .bind(onNext: { (vm, _) in
                vm.saveNickname()
                vm.coordinator?.showJoinMbtiViewController(with: self.signUpFlow)
            })
            .disposed(by: disposeBag)
        
        return Output(isTextFieldEditingDidBegin: isTextFielEditingDidBegin,
                      isTextFieldEditingChanged: isTextFieldEditingChanged,
                      isDuplicatedNickname: isDuplicatedNickname,
                      isTextFieldChanged: isTextFieldChanged)
    }
}

extension NicknameViewModel {
    
    private func loadNicknameDuplication() {
        guard let userId = UserDefaults.standard.string(forKey: "userId"),
              let nickname = self.nickname else { return }
        let query = NicknameDuplicationQuery(user_id: userId, user_nickname: nickname)
        
        Task {
            let nicknameDuplication = try await settingUseCase.executeNicknameDuplication(query: query)
            print("🔥", nicknameDuplication)
            if nicknameDuplication.code == 200 {
                isDuplicatedNickname.accept(false)
                UserDefaultManager.nickname = query.user_nickname
            } else {
                isDuplicatedNickname.accept(true)
            }
        }
    }
}

// MARK: UserDefaultManager
extension NicknameViewModel {
    private func saveNickname() {
        guard let nickname = self.nickname else { return }
        UserDefaultManager.nickname = nickname
    }
}
