//
//  SignupTermsViewModel.swift
//  SideProject-MovieApp
//
//  Created by Kim TaeSoo on 2023/03/27.
//

import Foundation
import RxSwift
import RxCocoa

final class TermsOfUseViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    private let signUpFlow: AuthCoordinator.SignUpFlow
    
    struct Input {
        let acceptButtonTapped: ControlEvent<Void>
        let totalAgreedButtonTapped: ControlEvent<Void>
        let ageAgreeButtonTapped: ControlEvent<Void>
        let dimoTermsButtonTapped: ControlEvent<Void>
        let privacyTermsButtonTapped: ControlEvent<Void>
        let eventPushNotiButtonTapped: ControlEvent<Void>
    }
    struct Output {
        let totalValid: BehaviorSubject<[Bool]>
    }
    
    init(coordinator: AuthCoordinator? = nil, signUpFlow: AuthCoordinator.SignUpFlow) {
        self.coordinator = coordinator
        self.signUpFlow = signUpFlow
    }
    
    func transform(input: Input) -> Output {
        
        let totalValidSubject = BehaviorSubject<[Bool]>(value: [false, false, false, false])
        
        input.ageAgreeButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            guard var totalValid = try? totalValidSubject.value() else { return }
            if totalValid[0] == true {
                totalValid[0] = false
            } else {
                totalValid[0] = true
            }
            print(totalValid)
            totalValidSubject.onNext(totalValid)
        }.disposed(by: disposeBag)
        
        input.dimoTermsButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            guard var totalValid = try? totalValidSubject.value() else { return }
            if totalValid[1] == true {
                totalValid[1] = false
            } else {
                totalValid[1] = true
            }
            print(totalValid)
            totalValidSubject.onNext(totalValid)
        }.disposed(by: disposeBag)
        
        input.privacyTermsButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            guard var totalValid = try? totalValidSubject.value() else { return }
            if totalValid[2] == true {
                totalValid[2] = false
            } else {
                totalValid[2] = true
            }
            print(totalValid)
            totalValidSubject.onNext(totalValid)
        }.disposed(by: disposeBag)
        
        input.eventPushNotiButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            guard var totalValid = try? totalValidSubject.value() else { return }
            if totalValid[3] == true {
                totalValid[3] = false
            } else {
                totalValid[3] = true
            }
            print(totalValid)
            totalValidSubject.onNext(totalValid)
        }.disposed(by: disposeBag)
        
        input.totalAgreedButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            guard var totalValid = try? totalValidSubject.value() else { return }
            if totalValid[0] && totalValid[1] && totalValid[2] && totalValid[3] == true {
                totalValid = [false, false, false, false]
            } else {
                totalValid = [true, true, true, true]
            }
            print(totalValid)
            totalValidSubject.onNext(totalValid)
        }.disposed(by: disposeBag)
        
        switch self.signUpFlow {
        case .dimo:
            input.acceptButtonTapped
                .withLatestFrom(totalValidSubject)
                .withUnretained(self)
                .bind { vm, totalValid in
                    let isAgreed = totalValid[3]
                    self.savePushCheck(isAgreed)
                    vm.coordinator?.showSignupIdentificationViewController(with: self.signUpFlow)
                }
                .disposed(by: disposeBag)
            
        case .sns:
            input.acceptButtonTapped
                .withLatestFrom(totalValidSubject)
                .withUnretained(self)
                .bind { vm, totalValid in
                    let isAgreed = totalValid[3]
                    self.savePushCheck(isAgreed)
                    vm.coordinator?.showNickNameViewController(with: self.signUpFlow)
                }
                .disposed(by: disposeBag)
        }
        
        return Output(totalValid: totalValidSubject)
    }
    
}

// MARK: - UserDefaultManager
extension TermsOfUseViewModel {
    
    private func savePushCheck(_ isAgreed: Bool) {
        if isAgreed {
            UserDefaultManager.pushCheck = 1
        } else {
            UserDefaultManager.pushCheck = 0
        }
    }
}
