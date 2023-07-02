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
    
    struct Input {
        var textFieldEditingDidBegin: ControlEvent<Void>
        var textFieldEditingChanged: ControlEvent<Void>
        var textFieldEditingDidEnd: ControlEvent<Void>
        var textFieldInput: ControlProperty<String?>
        var nicknameDuplicationButtonTapped: ControlEvent<Void>
        var nicknameChangeButtonTapped: ControlEvent<Void>
        var viewDidLoad: Signal<Void>
    }
    
    struct Output {
        var isTextFieldEditingDidBegin: BehaviorRelay<Bool>
        var isTextFieldEditingDidEnd: BehaviorRelay<Bool>
        var isTextFieldEditingChanged: BehaviorRelay<Bool>
        var isDuplicatedNickname: BehaviorRelay<Bool>
        var isTextFieldChanged: BehaviorRelay<Bool>
    }
    
    private var nickname: String?
    private var isDuplicatedNickname = BehaviorRelay<Bool>(value: true)
    private var isTextFielEditingDidBegin = BehaviorRelay<Bool>(value: false)
    private var isTextFieldChanged = BehaviorRelay<Bool>(value: false)
    private var isTextFieldEditingChanged = BehaviorRelay<Bool>(value: false)
    private var isTextFieldEiditinDidEnd = BehaviorRelay<Bool>(value: false)
    
    init(coordinator: SettingCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(input: Input) -> Output {
        input.textFieldInput
            .bind { [weak self] text in
                guard let text = text else { return }
                self?.nickname = text
                if text.count < 2 {
                    self?.isTextFieldEditingChanged.accept(false)
                } else {
                    self?.isTextFieldEditingChanged.accept(true)
                }
            }
            .disposed(by: disposeBag)
        
        input.textFieldEditingDidBegin
            .bind { [weak self] in
                self?.isTextFielEditingDidBegin.accept(true)
            }
            .disposed(by: disposeBag)
        
        input.textFieldEditingChanged
            .bind { [weak self] in
                self?.isTextFieldChanged.accept(true)
            }
            .disposed(by: disposeBag)
        
        input.textFieldEditingDidEnd
            .bind { [weak self] in
                self?.isTextFieldEiditinDidEnd.accept(true)
            }
            .disposed(by: disposeBag)
        
        input.viewDidLoad.emit { _ in
            self.loadNicknameChangeDate()
        }
        .disposed(by: disposeBag)
        
        input.nicknameDuplicationButtonTapped
            .bind(onNext: { [weak self] in
                self?.checkDuplicationNickname()
            })
            .disposed(by: disposeBag)
        
        input.nicknameChangeButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showAlertEditUserNameViewController(with: self?.nickname)
        }.disposed(by: disposeBag)
        
        return Output(isTextFieldEditingDidBegin: isTextFielEditingDidBegin,
                      isTextFieldEditingDidEnd: isTextFieldEiditinDidEnd,
                      isTextFieldEditingChanged: isTextFieldEditingChanged,
                      isDuplicatedNickname: isDuplicatedNickname,
                      isTextFieldChanged: isTextFieldChanged)
    }
    
    private func checkDuplicationNickname() {
        guard let userId = UserDefaults.standard.string(forKey: "userId"),
              let nickname = self.nickname else { return }
        let query = NicknameDuplicationQuery(user_id: userId, user_nickname: nickname)
        
        Task { @MainActor () -> Void in
            let nicknameDuplication = try await settingUseCase.executeDuplication(query: query)
            print("🔥", nicknameDuplication)
            if nicknameDuplication.code == 200 {
                isDuplicatedNickname.accept(false)
            } else {
                isDuplicatedNickname.accept(true)
            }
        }
    }
    
    func loadNicknameChangeDate() {
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        let query = NicknameChangeDateQuery(user_id: userId)
        let nicknameChangeDateObservable = self.settingUseCase.executeNicknameChangeDate(query: query)
        
        nicknameChangeDateObservable.bind { [weak self] changeDate in
            print("🔥", changeDate)
        }
    }
}
