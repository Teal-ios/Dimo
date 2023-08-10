//
//  EditMbtiViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation
import RxSwift
import RxCocoa

final class EditMbtiViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: SettingCoordinator?
    
    
    struct Input{
        let eButtonTapped: ControlEvent<Void>
        let iButtonTapped: ControlEvent<Void>
        let nButtonTapped: ControlEvent<Void>
        let sButtonTapped: ControlEvent<Void>
        let tButtonTapped: ControlEvent<Void>
        let fButtonTapped: ControlEvent<Void>
        let jButtonTapped: ControlEvent<Void>
        let pButtonTapped: ControlEvent<Void>
    }
    
    private var isEButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isIButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isNButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isSButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isTButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isFButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isJButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isPButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isValidMbti = BehaviorRelay<[String: Bool]>(value: ["E": false, "I": false, "N": false, "S": false, "T": false, "F": false, "J": false, "P": false])
    
    struct Output{
        let eButtonTapped: ControlEvent<Void>
        let iButtonTapped: ControlEvent<Void>
        let nButtonTapped: ControlEvent<Void>
        let sButtonTapped: ControlEvent<Void>
        let tButtonTapped: ControlEvent<Void>
        let fButtonTapped: ControlEvent<Void>
        let jButtonTapped: ControlEvent<Void>
        let pButtonTapped: ControlEvent<Void>
        let isValidMbti: BehaviorRelay<[String:Bool]>
    }
    
    init(coordinator: SettingCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.eButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isEButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": true,
                                           "I": false,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isEButtonTapped.accept(true)
                    vm.isIButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": false,
                                           "I": true,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isEButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        input.iButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isIButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": false,
                                           "I": true,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isIButtonTapped.accept(true)
                    vm.isEButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": true,
                                           "I": false,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isIButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        input.nButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isNButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": true,
                                           "S": false,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isNButtonTapped.accept(true)
                    vm.isSButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": false,
                                           "S": true,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isNButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        input.sButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isSButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": false,
                                           "S": true,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isSButtonTapped.accept(true)
                    vm.isNButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": true,
                                           "S": false,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isSButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        input.tButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isTButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": true,
                                           "F": false,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isTButtonTapped.accept(true)
                    vm.isFButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": false,
                                           "F": true,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isTButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        input.fButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isFButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": false,
                                           "F": true,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isFButtonTapped.accept(true)
                    vm.isTButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": true,
                                           "F": false,
                                           "J": vm.isJButtonTapped.value,
                                           "P": vm.isPButtonTapped.value])
                    vm.isFButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        input.jButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isJButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": true,
                                           "P": false])
                    vm.isJButtonTapped.accept(true)
                    vm.isPButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": false,
                                           "P": true])
                    vm.isJButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        input.pButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isPButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": false,
                                           "P": true])
                    vm.isPButtonTapped.accept(true)
                    vm.isJButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": vm.isEButtonTapped.value,
                                           "I": vm.isIButtonTapped.value,
                                           "N": vm.isNButtonTapped.value,
                                           "S": vm.isSButtonTapped.value,
                                           "T": vm.isTButtonTapped.value,
                                           "F": vm.isFButtonTapped.value,
                                           "J": true,
                                           "P": false])
                    vm.isPButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
    
//        input.isValidMbti
//            .withUnretained(self)
//            .bind { (vm, mbti) in
//                var count = 0
//                
//                for i in mbti {
//                    if i == true {
//                        count += 1
//                    }
//                    if count == 4 {
//                        self.checkMbitiValidation(mbti: mbti)
//                    }
//                }
//            }
//            .disposed(by: disposeBag)
        
        return Output(eButtonTapped: input.eButtonTapped,
                      iButtonTapped: input.iButtonTapped,
                      nButtonTapped: input.nButtonTapped,
                      sButtonTapped: input.sButtonTapped,
                      tButtonTapped: input.tButtonTapped,
                      fButtonTapped: input.fButtonTapped,
                      jButtonTapped: input.jButtonTapped,
                      pButtonTapped: input.pButtonTapped,
                      isValidMbti: self.isValidMbti)
    }
}

extension EditMbtiViewModel {
    private func checkMbitiValidation(mbti: [Bool]) {
        var mbtiString = ""
        
        for i in 0..<mbti.count {
            if mbti[i] == true {
                switch i {
                case 0:
                    mbtiString += "E"
                case 1:
                    mbtiString += "I"
                case 2:
                    mbtiString += "N"
                case 3:
                    mbtiString += "S"
                case 4:
                    mbtiString += "T"
                case 5:
                    mbtiString += "F"
                case 6:
                    mbtiString += "J"
                case 7:
                    mbtiString += "P"
                default:
                    break
                }
            }
        }
//        self.isValidMbti.accept(true)
        print("🔥 MBTI STRING: \(mbtiString)")
    }
}
