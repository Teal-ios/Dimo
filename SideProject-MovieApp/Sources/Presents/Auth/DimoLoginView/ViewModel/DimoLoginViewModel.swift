//
//  DimoLoginViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/13.
//

import Foundation
import RxCocoa
import RxSwift

final class DimoLoginViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private var authUseCase: AuthUseCase
    private weak var coordinator: AuthCoordinator?
    
    struct Input{
        let nextButtonTapped: ControlEvent<Void>
        let idText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let idFindButtonTapped: ControlEvent<Void>
        let pwFindButtonTapped: ControlEvent<Void>
        let dimoFirstStartButtonTapped: ControlEvent<Void>
    }
    
    struct Output{
        var nextButtonTapped: ControlEvent<Void>
        let loginValid: Observable<Bool>
        let toastMessage: PublishRelay<String>
    }
    
    init(coordinator: AuthCoordinator? = nil, authUseCase: AuthUseCase) {
        self.coordinator = coordinator
        self.authUseCase = authUseCase
    }
    
    let loginRequestValid = BehaviorRelay<Bool>(value: false)
    let toastMessage = PublishRelay<String>()
    
    func transform(input: Input) -> Output {
        var userId = ""
        var password = ""
        
        input.idText.bind { id in
            guard let id = id else { return }
            userId = id
        }
        .disposed(by: disposeBag)
        
        input.passwordText.bind { pw in
            guard let pw = pw else { return }
            password = pw
        }
        .disposed(by: disposeBag)
        
        input.nextButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            self.login(user_id: userId, password: password)
        }.disposed(by: disposeBag)
        
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$])[A-Za-z\\d!@#$]{8,16}$"
        
        let pwValid = input.passwordText
            .orEmpty
            .map {  NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: $0) }
            .share()
        
        let nicknameValid = input.idText.orEmpty.map { str in
            str.count > 3
        }
        
        let loginValid = Observable.combineLatest(nicknameValid, pwValid)
            .map { nickname, password in
                return nickname && password
            }
        
        input.idFindButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showFindIDViewController()
        }
        .disposed(by: disposeBag)
        
        input.pwFindButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showFindPWViewController()
        }
        .disposed(by: disposeBag)
        
        input.dimoFirstStartButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showJoinTermsViewController()
        }
        .disposed(by: disposeBag)
        
        self.loginRequestValid
            .observe(on: MainScheduler.instance)
            .bind { [weak self] bool in
                guard let self else { return }
                if bool == true {
                    self.coordinator?.connectHomeTabBarCoordinator()
                }
            }
            .disposed(by: disposeBag)
        
        return Output(nextButtonTapped: input.nextButtonTapped, loginValid: loginValid, toastMessage: self.toastMessage)
    }
}

extension DimoLoginViewModel {
    
    private func login(user_id: String, password: String) {
        let query = LoginQuery(user_id: user_id, password: password)
        
        Task {
            let login = try await authUseCase.excuteLogin(query: query)
            print("🔥", login)
            
            if login.code == 200 {
                loginRequestValid.accept(true)
            } else {
                toastMessage.accept("아이디 비밀번호를 확인해 주세요.")
            }
        }
    }
}

