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
    var disposeBag: DisposeBag = DisposeBag()
    var leftTime: Int?
    
    struct Input {
        var phoneNumberInput: ControlProperty<String?>
        var telecomButtonTapped: ControlEvent<Void>
        var idInput: ControlProperty<String?>
        var nameInput: ControlProperty<String?>
        var nextButtonTapped: ControlEvent<Void>
    }
    struct Output {
        var phoneNumberOutput: ControlProperty<String>
        var phoneNumberValid: Observable<Bool>
        var telecomButtonTapped: ControlEvent<Void>
        var nextButtonTapped: ControlEvent<Void>
        var nextButtonValid: Observable<Bool>
    }
    
    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
        
    }
    
    func transform(input: Input) -> Output {
        let phoneStr = input.phoneNumberInput.orEmpty
        let nameValid = input.nameInput.orEmpty.map { str in
            return str.count >= 2 && str.count <= 15
        }
        let phoneValid = input.phoneNumberInput.orEmpty.map { str in
            return str.count == 12 || str.count == 13
        }
        let idValid = input.idInput.orEmpty.map { str in
            return str.count >= 6
        }
        let idCheck = input.idInput.orEmpty.map { str in
            // 인증번호 확인 해야함
            return true
        }
        let valid = Observable.combineLatest(nameValid, phoneValid, idValid).map {
            return $0 && $1 && $2
        }
        
        
        input.nextButtonTapped.bind { [weak self] _ in
            self?.coordinator?.showSendMessageViewController()
        }.disposed(by: disposeBag)
        
        return Output(phoneNumberOutput: phoneStr, phoneNumberValid: phoneValid, telecomButtonTapped: input.telecomButtonTapped, nextButtonTapped: input.nextButtonTapped ,nextButtonValid: valid)
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
        
        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            
            if number.count <= 10{
                number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            } else if number.count == 11 {
                number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            }
        }
        
        return number
    }
}
