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
    var id: String? = ""
    var duplicationValid = BehaviorRelay<Bool>(value: false)
    var nicknameDuplicationData: BehaviorRelay<NicknameDuplication>?
    
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
        let nicknameValid = input.textFieldInput.orEmpty.map { str in
            str.count > 2
        }
        
        input.textFieldInput.bind { [weak self] id in
            self?.id = id
        }
        .disposed(by: disposeBag)
        
        input.duplicationButtonTap
            .bind(onNext: {
                Task { [weak self] in
                    guard let self = self else { return }
                    guard let userId = UserDefaults.standard.string(forKey: "userId"),
                          let userNickname = self.id else { return }
                    let query = NicknameDuplicationQuery(user_id: userId, user_nickname: userNickname)
                    let nicknameDuplication = try await self.settingUseCase.executeNicknameDuplication(query: query)
                    self.nicknameDuplicationData?.accept(nicknameDuplication)
                }
            })
            .disposed(by: disposeBag)
        
        self.nicknameDuplicationData?.bind(onNext: { [weak self] data in
            print("data들어옴")
            self?.duplicationValid.accept(true)
        })
        .disposed(by: disposeBag)
        
        
        
        
//        input.duplicationButtonTap
//            .flatMapLatest { [weak self] _ in
//                (self?.settingUseCase.executeNicknameDuplication(query: NicknameChangeQuery(user_id: UserDefaults.standard.string(forKey: "userId") ?? "",
//                                                                                            user_nickname: self?.id ?? ""))
//                    .do(onSuccess: { data in
//                        print(data, "data들어옴!!")
//                        self?.duplicationValid.accept(true)
//                    }, onError: { error in
//                        print(error)
//                    })
//                        .asObservable())!
//            }
//            .observe(on: MainScheduler.instance)  // 메인 스레드에서 실행하도록 함
//            .subscribe()
//            .disposed(by: disposebag)
        
        return Output(nicknameValid: nicknameValid, nextButtonValid: self.duplicationValid)
    }
}
