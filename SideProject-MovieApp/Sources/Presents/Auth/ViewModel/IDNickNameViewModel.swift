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
    private var currnetViewCases: CurrentViewCases
    private var authUseCase: AuthUseCase
    var id: String? = ""

    
    struct Input {
        var textFieldInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
        var duplicationButtonTap: ControlEvent<Void>
    }
    struct Output {
        var idNickNameValid: Observable<(policy: Bool, repeatCheck:Bool)>
    }
    init(coordinator: AuthCoordinator, currentViewCases: CurrentViewCases, authUseCase: AuthUseCase) {
        self.coordinator = coordinator
        self.currnetViewCases = currentViewCases
        self.authUseCase = authUseCase
    }
    func transform(input: Input) -> Output {
        
        
        
        input.nextButtonTapped.bind { [weak self] _ in
            switch self?.currnetViewCases {
            case .IDRegister:
                self?.coordinator?.showNickNameViewController()
            case .NickName:
                self?.coordinator?.showPasswordViewController()
            case .Password:
                self?.coordinator?.showPasswordViewController()
            default:
                print("currentView : Password")
            }
            
        }.disposed(by: disposebag)
        // 닉네임 중복확인
        let idNickNameValid = input.textFieldInput.map { str in
            return (policy:str != "태수", repeatCheck: true)
        }
        
        input.textFieldInput.bind { [weak self] id in
            self?.id = id
        }
        .disposed(by: disposebag)
        
        input.duplicationButtonTap
            .map {
                self.authUseCase.duplicationIdExcute(user_id: self.id ?? "")
            }
            .subscribe { data in
                print(data, "데이터들어왔다")
            } onError: { error in
                print(error)
            }
            .disposed(by: disposebag)
        
        return Output(idNickNameValid: idNickNameValid)
    }
}

enum CurrentViewCases {
    case IDRegister, NickName, Password
    
}
