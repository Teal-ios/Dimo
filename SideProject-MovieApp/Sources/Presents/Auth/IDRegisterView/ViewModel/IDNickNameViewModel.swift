//
//  IDNickNameViewModel.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/31.
//

import Foundation
import RxSwift
import RxCocoa

class IDNickNameViewModel: ViewModelType {
    var disposebag: DisposeBag = DisposeBag()
    
    private weak var coordinator: AuthCoordinator?
    private var authUseCase: AuthUseCase
    var id: String? = ""
    var duplicationValid = BehaviorRelay<Bool>(value: false)

    struct Input {
        var textFieldInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
        var duplicationButtonTap: ControlEvent<Void>
    }
    struct Output {
        var idValid: Observable<Bool>
        var nextButtonValid: BehaviorRelay<Bool>
    }
    init(coordinator: AuthCoordinator, authUseCase: AuthUseCase) {
        self.coordinator = coordinator
        self.authUseCase = authUseCase
    }
    func transform(input: Input) -> Output {
        
        
        
        input.nextButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showNickNameViewController()
        }.disposed(by: disposebag)
        
        // 닉네임 중복확인
        let idValid = input.textFieldInput.orEmpty.map { str in
            str.count > 3
        }
        
        input.textFieldInput.bind { [weak self] id in
            self?.id = id
        }
        .disposed(by: disposebag)

        
        input.duplicationButtonTap
            .flatMapLatest { [weak self] _ in
                (self?.authUseCase.duplicationIdExcute(user_id: self?.id ?? "")
                    .do(onSuccess: { data in
                        print(data, "data들어옴!!")
                        self?.duplicationValid.accept(true)
                    }, onError: { error in
                        print(error)
                    })
                        .asObservable())!
            }
            .observe(on: MainScheduler.instance)  // 메인 스레드에서 실행하도록 함
            .subscribe()
            .disposed(by: disposebag)
        
        
        return Output(idValid: idValid, nextButtonValid: self.duplicationValid)
    }
}


