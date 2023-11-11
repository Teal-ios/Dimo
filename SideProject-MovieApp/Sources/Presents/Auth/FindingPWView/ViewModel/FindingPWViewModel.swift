//
//  FindingPWViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import Foundation
import RxSwift
import RxCocoa

final class FindPWViewModel: ViewModelType {
    private weak var coordinator: AuthCoordinator?
    private let authUseCase: AuthUseCase
    var disposeBag: DisposeBag = DisposeBag()
    var leftTime: Int?
    
    struct Input {
        var phoneNumberInput: ControlProperty<String?>
        var telecomButtonTapped: ControlEvent<Void>
        var idInput: ControlProperty<String?>
        var nameInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
    }
    
    private var userId: String?
    private var agency: String?
    private var formattedPhoneNum = BehaviorRelay<String?>(value: nil)
    private var isInvalidUser = PublishRelay<Bool>()
    
    struct Output {
        var formattedPhoneNumber: BehaviorRelay<String?>
        var phoneNumberValid: Observable<Bool>
        var telecomButtonTapped: ControlEvent<Void>
        var nextButtonTapped: ControlEvent<Void>
        var nextButtonValid: Observable<Bool>
        var isInvalidateUser: PublishRelay<Bool>
    }
    
    init(authUseCase: AuthUseCase, coordinator: AuthCoordinator?) {
        self.authUseCase = authUseCase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.phoneNumberInput
            .orEmpty
            .withUnretained(self)
            .bind { (vm, text) in
                let formattedPhoneNum = vm.authUseCase.formatPhoneNumber(text, shouldRemoveLastDigit: false)
                vm.formattedPhoneNum.accept(formattedPhoneNum)
            }
            .disposed(by: disposeBag)
            
        input.idInput
            .withUnretained(self)
            .bind { (vm, text) in
                vm.userId = text
            }
            .disposed(by: disposeBag)
        
        let nameValid = input.nameInput.orEmpty.map { str in
            return str.count >= 2 && str.count <= 15
        }
        
        let phoneValid = input.phoneNumberInput.orEmpty.map { str in
            return str.count == 12 || str.count == 13
        }
        
        let idValid = input.idInput.orEmpty.map { str in
            return str.count >= 6
        }
        
        let valid = Observable.combineLatest(nameValid, phoneValid, idValid).map {
            return $0 && $1 && $2
        }
        
        input.nextButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                guard let userId = self.userId,
                      let phoneNum = self.formattedPhoneNum.value else { return }
                vm.loadPasswordFind(userId: userId, phoneNum: phoneNum)
            }
            .disposed(by: disposeBag)
        
        return Output(formattedPhoneNumber: self.formattedPhoneNum,
                      phoneNumberValid: phoneValid,
                      telecomButtonTapped: input.telecomButtonTapped,
                      nextButtonTapped: input.nextButtonTapped,
                      nextButtonValid: valid,
                      isInvalidateUser: self.isInvalidUser)
    }
    
    func set(agency: String) {
        self.agency = agency
    }
}

extension FindPWViewModel {
    
    func loadPasswordFind(userId: String, phoneNum: String) {
        let query = PasswordFindQuery(user_id: userId, phone_number: phoneNum)
        
        Task {
            let passwordFind = try await authUseCase.executePasswordFind(query: query)
            print("✅ Password Find ", passwordFind)
            
            if passwordFind.code == 200 {
                await MainActor.run {
                    self.coordinator?.showSendMessageViewController()
                }
            } else {
                self.isInvalidUser.accept(false)
            }
        }
    }
}
