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
    var disposeBag: DisposeBag = DisposeBag()
    
    private weak var coordinator: AuthCoordinator?
    private var authUseCase: AuthUseCase
    var id: String? = ""
    var duplicationValid = PublishRelay<Bool>()

    struct Input {
        var textFieldInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
        var duplicationButtonTap: ControlEvent<Void>
    }
    struct Output {
        var idValid: Observable<Bool>
        var nextButtonValid: PublishRelay<Bool>
    }
    init(coordinator: AuthCoordinator, authUseCase: AuthUseCase) {
        self.coordinator = coordinator
        self.authUseCase = authUseCase
    }
    func transform(input: Input) -> Output {
        
        input.nextButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showNickNameViewController(coordinatorFlow: .authFlow)
        }.disposed(by: disposeBag)
        
        // 닉네임 중복확인
        let idValid = input.textFieldInput.orEmpty.map { str in
            str.count > 3
        }
        
        input.textFieldInput.bind { [weak self] id in
            self?.id = id
        }
        .disposed(by: disposeBag)

        input.duplicationButtonTap
            .bind { [weak self] _ in
                guard let self else { return }
                self.duplcationIdCheck(user_Id: self.id ?? "")
            }
            .disposed(by: disposeBag)
        
        
        return Output(idValid: idValid, nextButtonValid: self.duplicationValid)
    }
}

extension IDNickNameViewModel {
    
    private func duplcationIdCheck(user_Id: String) {
        let query = DuplicationIdQuery(user_id: user_Id)
        
        Task {
            let duplicationId = try await authUseCase.executeDuplicationId(user_id: query.user_id)
            print("🔥", duplicationId)
            if duplicationId.code == 200 {
                UserDefaultManager.userId = query.user_id
                duplicationValid.accept(true)
            } else {
                duplicationValid.accept(false)
            }
        }
    }
}
