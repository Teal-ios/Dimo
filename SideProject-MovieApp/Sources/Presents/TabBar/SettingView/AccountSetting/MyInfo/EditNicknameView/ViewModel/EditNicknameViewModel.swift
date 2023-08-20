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
    var toast: ( () -> Void )?
    
    struct Input {
        var textFieldEditingDidBegin: ControlEvent<Void>
        var textFieldEditingChanged: ControlEvent<Void>
        var textFieldEditingDidEnd: ControlEvent<Void>
        var textFieldInput: ControlProperty<String?>
        var nicknameChangeButtonTapped: ControlEvent<Void>
        var viewDidLoad: PublishRelay<Void>
    }
    
    struct Output {
        var isTextFieldEditingDidBegin: BehaviorRelay<Bool>
        var isTextFieldEditingDidEnd: BehaviorRelay<Bool>
        var isTextFieldEditingChanged: BehaviorRelay<Bool>
        var isDuplicatedNickname: BehaviorRelay<Bool>
        var isTextFieldChanged: BehaviorRelay<Bool>
        var lastNicknameChangeDate: BehaviorRelay<String>
    }
    
    private var nickname: String?
    private(set) var nicknameChangeDate: Date?
    private var lastNicknameChangeDate = BehaviorRelay<String>(value: "")
    private var isDuplicatedNickname = BehaviorRelay<Bool>(value: true)
    private var isTextFielEditingDidBegin = BehaviorRelay<Bool>(value: false)
    private var isTextFieldChanged = BehaviorRelay<Bool>(value: false)
    private var isTextFieldEditingChanged = BehaviorRelay<Bool>(value: false)
    private var isTextFieldEiditinDidEnd = BehaviorRelay<Bool>(value: false)
    
    init(coordinator: SettingCoordinator, settingUseCase: SettingUseCase, nicknameChangeDate: Date?) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
        self.nicknameChangeDate = nicknameChangeDate
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
        
        input.viewDidLoad
            .withUnretained(self)
            .bind { (vm, _) in
//                vm.loadNicknameChangeDate()
            }
            .disposed(by: disposeBag)
        
        input.nicknameChangeButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showAlertEditUserNameViewController(with: self?.nickname, completion: self?.toast)
        }.disposed(by: disposeBag)
        
        return Output(isTextFieldEditingDidBegin: isTextFielEditingDidBegin,
                      isTextFieldEditingDidEnd: isTextFieldEiditinDidEnd,
                      isTextFieldEditingChanged: isTextFieldEditingChanged,
                      isDuplicatedNickname: isDuplicatedNickname,
                      isTextFieldChanged: isTextFieldChanged,
                      lastNicknameChangeDate: lastNicknameChangeDate)
    }
}

// MARK: Network
extension EditNicknameViewModel {
    
    private func loadNicknameChangeDate() {
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        let query = NicknameChangeDateQuery(user_id: userId)
        
        Task {
            let nicknameChangeDate = try await settingUseCase.executeNicknameChangeDate(query: query)
            print("🔥", nicknameChangeDate)
            if nicknameChangeDate.code == 200 {
                lastNicknameChangeDate.accept(nicknameChangeDate.message)
            } else { // 401
                lastNicknameChangeDate.accept(nicknameChangeDate.message)
            }
        }
    }
    
    private func loadNicknameDuplication() {
        guard let userId = UserDefaults.standard.string(forKey: "userId"),
              let nickname = self.nickname else { return }
        let query = NicknameDuplicationQuery(user_id: userId, user_nickname: nickname)
        
        Task {
            let nicknameDuplication = try await settingUseCase.executeNicknameDuplication(query: query)
            print("🔥", nicknameDuplication)
            if nicknameDuplication.code == 200 {
                isDuplicatedNickname.accept(false)
            } else {
                isDuplicatedNickname.accept(true)
            }
        }
    }
}
