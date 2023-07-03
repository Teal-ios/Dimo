//
//  JoinTermsViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/29.
//

import Foundation
import RxSwift
import RxCocoa

final class JoinTermsViewModel: ViewModelType {
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
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
    
    init(coordinator: AuthCoordinator? = nil) {
        self.coordinator = coordinator
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
        
        input.acceptButtonTapped.bind { [weak self] _ in
            guard let self = self else { return }
            self.coordinator?.showSignupIdentificationViewController()
        }.disposed(by: disposeBag)
        
        return Output(totalValid: totalValidSubject)
    }
}
