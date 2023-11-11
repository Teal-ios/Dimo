//
//  FindIDViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/11.
//

import Foundation
import RxSwift
import RxCocoa

final class FindIDViewModel: ViewModelType {
    private weak var coordinator: AuthCoordinator?
    private let authUseCase: AuthUseCase
    var disposeBag: DisposeBag = DisposeBag()
    var timer: Timer?
    var leftTime: Int?
    
    struct Input {
        var phoneNumberInput: ControlProperty<String?>
        var telecomButtonTapped: ControlEvent<Void>
        var authCodeInput: ControlProperty<String?>
        var nameInput: ControlProperty<String?>
        var didTappedRequestButtonTapped: ControlEvent<Void>
        var nextButtonTapped: ControlEvent<Void>
    }
    
    private var name: String?
    private var agency: String? // 통신사
    private var verifyCode: String? // 메세지 인증번호
    private var formattedPhoneNum = BehaviorRelay<String?>(value: nil)
    private var authCode: String?
    private var isInvalidCode = PublishRelay<Bool>()
    private var isInvalidUser = PublishRelay<Bool>()
    
    struct Output {
        var formattedPhoneNumber: BehaviorRelay<String?>
        var phoneNumberValid: Observable<Bool>
        var telecomButtonTapped: ControlEvent<Void>
        var idRequestButtonTapped: ControlEvent<Void>
        var nextButtonTapped: ControlEvent<Void>
        var nextButtonValid: Observable<Bool>
        var isInvalidateCode: PublishRelay<Bool>
        var isInvalidateUser: PublishRelay<Bool>
    }
    
    init(coordinator: AuthCoordinator?, authUseCase: AuthUseCase) {
        self.coordinator = coordinator
        self.authUseCase = authUseCase
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
        
        let nameValid = input.nameInput.orEmpty.map { str in
            return str.count >= 2 && str.count <= 15
        }
        
        input.nameInput
            .withUnretained(self)
            .bind { (vm, name) in
                vm.name = name
            }
            .disposed(by: disposeBag)
        
        let phoneValid = input.phoneNumberInput.orEmpty.map { str in
            return str.count == 12 || str.count == 13
        }
        let authValid = input.authCodeInput.orEmpty.map { str in
            return str.count == 6
        }
        let authCheck = input.authCodeInput.orEmpty.map { str in
            // 인증번호 확인 해야함
            return true
        }
        let valid = Observable.combineLatest(nameValid, phoneValid, authValid).map {
            return $0 && $1 && $2
        }
        
        input.authCodeInput
            .withUnretained(self)
            .bind { (vm, value) in
                vm.authCode = value
            }
            .disposed(by: disposeBag)
        
        input.didTappedRequestButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                guard let phoneNumber = vm.formattedPhoneNum.value else { return }
                vm.loadPhoneNumCheck(with: phoneNumber)
            }
            .disposed(by: disposeBag)
        
        
        input.nextButtonTapped
            .withUnretained(self)
            .bind(onNext: { (vm, _) in
                guard let name = vm.name,
                      let agency = vm.agency,
                      let phoneNum = vm.formattedPhoneNum.value,
                      let authCode = vm.authCode else { return }
                let idFindQuery = IdFindQuery(name: name, agency: agency, phone_number: phoneNum, ver_code: authCode)
                vm.loadIdFind(query: idFindQuery)
            })
            .disposed(by: disposeBag)
        
        return Output(formattedPhoneNumber: formattedPhoneNum,
                      phoneNumberValid: phoneValid,
                      telecomButtonTapped: input.telecomButtonTapped,
                      idRequestButtonTapped: input.didTappedRequestButtonTapped,
                      nextButtonTapped: input.nextButtonTapped,
                      nextButtonValid: valid,
                      isInvalidateCode: self.isInvalidCode,
                      isInvalidateUser: self.isInvalidUser)
    }
    
    func set(agency: String) {
        self.agency = agency
    }
}

extension FindIDViewModel {
    
    func loadPhoneNumCheck(with phoneNum: String) {
        let query = PhoneNumberCheckQuery(phone_number: phoneNum)
        print("✅ PhoneNum ", phoneNum)
        Task {
            let phoneNumCheck = try await authUseCase.executePhoneNumCheck(query: query)
            print("✅ PhoneNumCheck ", phoneNumCheck)
            
            if phoneNumCheck.msg == "success" {
                
            }
        }
    }
    
    func loadIdFind(query: IdFindQuery) {
        print("✅ IdFindQuery: ", query)
        Task {
            let idFind = try await authUseCase.executeIdFind(query: query)
            if idFind.code == 200 {
                await MainActor.run {
                     self.coordinator?.showNotificationIDViewController()
                }
            } else if idFind.code == 400 {
                self.isInvalidCode.accept(false)
            } else if idFind.code == 401 {
                self.isInvalidUser.accept(false)
            }
        }
    }

}
