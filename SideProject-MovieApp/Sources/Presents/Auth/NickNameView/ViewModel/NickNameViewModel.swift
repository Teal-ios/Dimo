//
//  NickNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift
import RxCocoa

//class NickNameViewModel: ViewModelType {
//
//    enum CoordinatorFlow {
//        case authFlow
//        case socialLoginFlow
//    }
//
//    var disposeBag: DisposeBag = DisposeBag()
//
//    private weak var coordinator: AuthCoordinator?
//    private var settingUseCase: SettingUseCase
//    private var nickname: String?
//    private var duplicationValid = PublishRelay<Bool>()
//    private var coordinatorFlow: CoordinatorFlow
//
//    struct Input {
//        var textFieldInput: ControlProperty<String?>
//        var nextButtonTapped: ControlEvent<Void>
//        var duplicationButtonTap: ControlEvent<Void>
//    }
//
//    struct Output {
//        var nicknameValid: Observable<Bool>
//        var nextButtonValid: PublishRelay<Bool>
//    }
//
//    init(coordinator: AuthCoordinator? = nil, settingUseCase: SettingUseCase, coordinatorFlow: CoordinatorFlow) {
//        self.coordinator = coordinator
//        self.settingUseCase = settingUseCase
//        self.coordinatorFlow = coordinatorFlow
//    }
//
//    func transform(input: Input) -> Output {
//        input.nextButtonTapped.bind { [weak self] _ in
//            guard let self = self else { return }
//            switch self.coordinatorFlow {
//            case .authFlow:
//                self.coordinator?.showPasswordViewController()
//            case .socialLoginFlow:
//                self.coordinator?.showJoinMbtiViewController()
//            }
//        }.disposed(by: disposeBag)
//
//        // 닉네임 중복확인
//        let isValidNickname = input.textFieldInput.orEmpty.map { str in
//            str.count >= 2
//        }
//
//        input.textFieldInput.bind { [weak self] nickname in
//            self?.nickname = nickname
//        }
//        .disposed(by: disposeBag)
//
//        input.duplicationButtonTap
//            .bind { [weak self] _ in
//                guard let self else { return }
//                guard let userId = UserDefaults.standard.string(forKey: "userId") else { return }
//                guard let nickname = self.nickname else { return }
//                self.duplicationNicknameCheck(user_id: userId, user_nickname: nickname)
//                self.duplicationNicknameCheck(user_id: userId, user_nickname: nickname)
//            }
//            .disposed(by: disposeBag)
//
//        return Output(nicknameValid: isValidNickname, nextButtonValid: self.duplicationValid)
//    }
//}
//
//extension NickNameViewModel {
//
//    private func duplicationNicknameCheck(user_id: String, user_nickname: String) {
//
//        let query = NicknameDuplicationQuery(user_id: user_id, user_nickname: user_nickname)
//        Task {
//            let duplicationNickname = try await settingUseCase.executeNicknameDuplication(query: query)
//            print("🔥", duplicationNickname)
//            if duplicationNickname.code == 200 {
//                UserDefaultManager.nickname = query.user_nickname
//                duplicationValid.accept(true)
//            } else {
//                duplicationValid.accept(false)
//            }
//        }
//    }
//}

final class NicknameViewModel: ViewModelType {
    
    enum CoordinatorFlow {
        case authFlow
        case socialLoginFlow
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    private var settingUseCase: SettingUseCase
    private weak var coordinator: AuthCoordinator?
    
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
    
    init(coordinator: AuthCoordinator, settingUseCase: SettingUseCase, coordinatorFlow: CoordinatorFlow) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
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
            .bind { (vm, _) in
                vm.coordinator?.showJoinMbtiViewController()
            }
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
            } else {
                isDuplicatedNickname.accept(true)
            }
        }
    }
}
