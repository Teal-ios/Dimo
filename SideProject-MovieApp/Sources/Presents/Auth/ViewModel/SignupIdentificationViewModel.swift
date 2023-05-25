//
//  SignupIdentificationViewModel.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import Foundation
import RxSwift
import RxCocoa

final class SignupIdentificationViewModel: ViewModelType {
    private weak var coordinator: AuthCoordinator?
    private var authUseCase: AuthUseCase
    var disposebag: DisposeBag = DisposeBag()
    var timer: Timer?
    var leftTime: Int?
    var phoneNum: String? = ""
    
    struct Input {
        var phoneNumberInput: ControlProperty<String?>
        var telecomButtonTapped: ControlEvent<Void>
        var authInput: ControlProperty<String?>
        var nameInput: ControlProperty<String?>
        var idRequestButtonTapped: ControlEvent<Void>
        var nextButtonTapped: ControlEvent<Void>
    }
    struct Output {
        var phoneNumberOutput: ControlProperty<String>
        var phoneNumberValid: Observable<Bool>
        var telecomButtonTapped: ControlEvent<Void>
        var idRequestButtonTapped: ControlEvent<Void>
        var nextButtonTapped: ControlEvent<Void>
        var nextButtonValid: Observable<Bool>
    }
    
    init(coordinator: AuthCoordinator?, authUseCase: AuthUseCase) {
        self.coordinator = coordinator
        self.authUseCase = authUseCase
    }
    
    func transform(input: Input) -> Output {
        let phoneStr = input.phoneNumberInput.orEmpty
        let nameValid = input.nameInput.orEmpty.map { str in
            return str.count >= 2 && str.count <= 15
        }
        let phoneValid = input.phoneNumberInput.orEmpty.map { str in
            return str.count == 12 || str.count == 13
        }
        let authValid = input.authInput.orEmpty.map { str in
            return str.count == 6
        }
        let authCheck = input.authInput.orEmpty.map { str in
            // 인증번호 확인 해야함
            return true
        }
        let valid = Observable.combineLatest(nameValid, phoneValid, authValid).map {
            return $0 && $1 && $2
        }
        
        input.phoneNumberInput.bind { [weak self] phoneNum in
            self?.phoneNum = phoneNum
        }
        .disposed(by: disposebag)
        
        input.idRequestButtonTapped
            .map {
                self.authUseCase.phoneNumberCheckExcute(phone_number: self.phoneNum ?? "")
            }
            .subscribe { data in
                print(data, "데이터들어왔다")
            } onError: { error in
                print(error)
            }
            .disposed(by: disposebag)
        
        input.nextButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showIDRegisterViewController()
        }.disposed(by: disposebag)
        
        return Output(phoneNumberOutput: phoneStr, phoneNumberValid: phoneValid, telecomButtonTapped: input.telecomButtonTapped, idRequestButtonTapped: input.idRequestButtonTapped, nextButtonTapped: input.nextButtonTapped ,nextButtonValid: valid)
    }
    ///  추후 USECase로 뺄 예정입니다!
    func phoneNumberFormat(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 11 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 11)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 8 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            
            if number.count <= 10 {
                number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            } else if number.count == 11 {
                number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            }
        }
        
        return number
    }
}
