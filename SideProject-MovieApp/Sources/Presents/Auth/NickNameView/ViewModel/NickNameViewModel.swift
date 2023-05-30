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
    var disposebag: DisposeBag = DisposeBag()
    
    private weak var coordinator: AuthCoordinator?
    private var settingUseCase: SettingUseCase
    var id: String? = ""

    
    struct Input {
        var textFieldInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
        var duplicationButtonTap: ControlEvent<Void>
    }
    struct Output {
        var nickNameValid: Observable<(policy: Bool, repeatCheck:Bool)>
    }
    init(coordinator: AuthCoordinator, settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    func transform(input: Input) -> Output {
        
        // 닉네임 중복확인
        let idNickNameValid = input.textFieldInput.map { str in
            return (policy:str != "태수", repeatCheck: true)
        }
        
        input.textFieldInput.bind { [weak self] id in
            self?.id = id
        }
        .disposed(by: disposebag)
        
        let duplicationButtonTapAsync = input.duplicationButtonTap
            .flatMapLatest { [weak self] _ -> Single<DuplicationNickname> in
                guard let self = self else {
                    return Single.error(NSError(domain: "", code: 0, userInfo: nil))
                }
                let user_id = UserDefaults.standard.string(forKey: "id") ?? ""
                let user_nickname = "이름"
                return Single<DuplicationNickname>.create { single in
                    async {
                        do {
                            let duplicationNickname = try await self.settingUseCase.duplicationNicknameExcute(user_id: user_id, user_nickname: user_nickname)
                            single(.success(duplicationNickname))
                        } catch {
                            single(.failure(error))
                        }
                    }
                    return Disposables.create()
                }
            }

        
        duplicationButtonTapAsync
            .subscribe(onNext: { duplicationNickname in
                // 중복 확인 결과 처리
                print(duplicationNickname)
            }, onError: { error in
                // 에러 처리
                print(error)
            })
            .disposed(by: disposebag)
        
        
        return Output(nickNameValid: idNickNameValid)
    }
}
