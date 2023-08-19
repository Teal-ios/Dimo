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
    private let settingUseCase: SettingUseCase
    
    struct Input{
        let eButtonTapped: ControlEvent<Void>
        let iButtonTapped: ControlEvent<Void>
        let nButtonTapped: ControlEvent<Void>
        let sButtonTapped: ControlEvent<Void>
        let tButtonTapped: ControlEvent<Void> 
        let fButtonTapped: ControlEvent<Void>
        let jButtonTapped: ControlEvent<Void>
        let pButtonTapped: ControlEvent<Void>
        let changeButtonTapped: ControlEvent<Void>
    }
    
    private var isMbtiChangedOverOneMonth = BehaviorRelay<Bool?>(value: nil)
    private var isEButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isIButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isNButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isSButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isTButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isFButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isJButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isPButtonTapped = BehaviorRelay<Bool>(value: false)
    private var isValidMbti = BehaviorRelay<[String: Bool]>(value: ["E": false, "I": false, "N": false, "S": false, "T": false, "F": false, "J": false, "P": false])
    private(set) var selectedMbti = BehaviorRelay<String>(value: "")
    private let isChanged = BehaviorRelay<Bool>(value: false)
    private(set) var userMbti = BehaviorRelay<String?>(value: nil)
    private var mbtiChangedDate = BehaviorRelay<Date?>(value: nil)
    
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
        let isChanged: BehaviorRelay<Bool>
        let selectedMbti: BehaviorRelay<String>
        let isMbtiChangedOverOneMonth: BehaviorRelay<Bool?>
        let mbtiChangedDate: BehaviorRelay<Date?>
    }
    
    init(coordinator: SettingCoordinator? = nil, settingUseCase: SettingUseCase, mbti: String?, mbtiChangeDate: Date?) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
        self.userMbti.accept(mbti)
        self.mbtiChangedDate.accept(mbtiChangeDate)
    }
    
    func transform(input: Input) -> Output {
        
        self.mbtiChangedDate
            .withUnretained(self)
            .bind { (vm, changedDate) in
                guard let changedDate = changedDate else { return }
                let isMbtiChangedOverOneMonth = Date.checkOverOneMonth(from: changedDate)
                vm.isMbtiChangedOverOneMonth.accept(isMbtiChangedOverOneMonth)
            }
            .disposed(by: disposeBag)
        
        let currentMbti = self.userMbti.value
        
        for mbti in currentMbti ?? "" {
            if mbti == "E" {
                self.isValidMbti.accept(["E": true,
                                         "I": false,
                                         "N": isValidMbti.value["N"] ?? false,
                                         "S": isValidMbti.value["S"] ?? false,
                                         "T": isValidMbti.value["T"] ?? false,
                                         "F": isValidMbti.value["F"] ?? false,
                                         "J": isValidMbti.value["J"] ?? false,
                                         "P": isValidMbti.value["P"] ?? false])
                self.isEButtonTapped.accept(true)
            } else if mbti == "I" {
                self.isValidMbti.accept(["E": false,
                                         "I": true,
                                         "N": isValidMbti.value["N"] ?? false,
                                         "S": isValidMbti.value["S"] ?? false,
                                         "T": isValidMbti.value["T"] ?? false,
                                         "F": isValidMbti.value["F"] ?? false,
                                         "J": isValidMbti.value["J"] ?? false,
                                         "P": isValidMbti.value["P"] ?? false])
                self.isIButtonTapped.accept(true)
            } else if mbti == "N" {
                self.isValidMbti.accept(["E": isValidMbti.value["E"] ?? false,
                                         "I": isValidMbti.value["I"] ?? false,
                                         "N": true,
                                         "S": false,
                                         "T": isValidMbti.value["T"] ?? false,
                                         "F": isValidMbti.value["F"] ?? false,
                                         "J": isValidMbti.value["J"] ?? false,
                                         "P": isValidMbti.value["P"] ?? false])
                self.isNButtonTapped.accept(true)
            } else if mbti == "S" {
                self.isValidMbti.accept(["E": isValidMbti.value["E"] ?? false,
                                         "I": isValidMbti.value["I"] ?? false,
                                         "N": false,
                                         "S": true,
                                         "T": isValidMbti.value["T"] ?? false,
                                         "F": isValidMbti.value["F"] ?? false,
                                         "J": isValidMbti.value["J"] ?? false,
                                         "P": isValidMbti.value["P"] ?? false])
                self.isSButtonTapped.accept(true)
            } else if mbti == "T" {
                self.isValidMbti.accept(["E": isValidMbti.value["E"] ?? false,
                                         "I": isValidMbti.value["I"] ?? false,
                                         "N": isValidMbti.value["N"] ?? false,
                                         "S": isValidMbti.value["S"] ?? false,
                                         "T": true,
                                         "F": false,
                                         "J": isValidMbti.value["J"] ?? false,
                                         "P": isValidMbti.value["P"] ?? false])
                self.isTButtonTapped.accept(true)
            } else if mbti == "F" {
                self.isValidMbti.accept(["E": isValidMbti.value["E"] ?? false,
                                         "I": isValidMbti.value["I"] ?? false,
                                         "N": isValidMbti.value["N"] ?? false,
                                         "S": isValidMbti.value["S"] ?? false,
                                         "T": false,
                                         "F": true,
                                         "J": isValidMbti.value["J"] ?? false,
                                         "P": isValidMbti.value["P"] ?? false])
                self.isFButtonTapped.accept(true)
            } else if mbti == "J" {
                self.isValidMbti.accept(["E": isValidMbti.value["E"] ?? false,
                                         "I": isValidMbti.value["I"] ?? false,
                                         "N": isValidMbti.value["N"] ?? false,
                                         "S": isValidMbti.value["S"] ?? false,
                                         "T": isValidMbti.value["T"] ?? false,
                                         "F": isValidMbti.value["F"] ?? false,
                                         "J": true,
                                         "P": false])
                self.isJButtonTapped.accept(true)
            } else if mbti == "P" {
                self.isValidMbti.accept(["E": isValidMbti.value["E"] ?? false,
                                         "I": isValidMbti.value["I"] ?? false,
                                         "N": isValidMbti.value["N"] ?? false,
                                         "S": isValidMbti.value["S"] ?? false,
                                         "T": isValidMbti.value["T"] ?? false,
                                         "F": isValidMbti.value["F"] ?? false,
                                         "J": false,
                                         "P": true])
                self.isPButtonTapped.accept(true)
            }
        }
        
        input.eButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                if vm.isEButtonTapped.value == false {
                    vm.isValidMbti.accept(["E": true,
                                           "I": false,
                                           "N": vm.isValidMbti.value["N"] ?? false,
                                           "S": vm.isValidMbti.value["S"] ?? false,
                                           "T": vm.isValidMbti.value["T"] ?? false,
                                           "F": vm.isValidMbti.value["F"] ?? false,
                                           "J": vm.isValidMbti.value["J"] ?? false,
                                           "P": vm.isValidMbti.value["P"] ?? false])
                    vm.isEButtonTapped.accept(true)
                    vm.isIButtonTapped.accept(false)
                } else {
                    vm.isValidMbti.accept(["E": false,
                                           "I": false,
                                           "N": vm.isValidMbti.value["N"] ?? false,
                                           "S": vm.isValidMbti.value["S"] ?? false,
                                           "T": vm.isValidMbti.value["T"] ?? false,
                                           "F": vm.isValidMbti.value["F"] ?? false,
                                           "J": vm.isValidMbti.value["J"] ?? false,
                                           "P": vm.isValidMbti.value["P"] ?? false])
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
                    vm.isValidMbti.accept(["E": false,
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
                                           "S": false,
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
                                           "N": false,
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
                                           "F": false,
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
                                           "T": false,
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
                                           "P": false])
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
                                           "J": false,
                                           "P": false])
                    vm.isPButtonTapped.accept(false)
                }
            }
            .disposed(by: disposeBag)
    
        self.isValidMbti
            .withUnretained(self)
            .bind { (vm, mbti) in
                var mbtiString = ""
                for (key, value) in mbti {
                    if value == true {
                        mbtiString += key
                    }
                }
                let sortedMbtiString = vm.sortMbti(mbtiString)
                vm.selectedMbti.accept(sortedMbtiString)
            }
            .disposed(by: disposeBag)
        
        input.changeButtonTapped
            .withUnretained(self)
            .bind { (vm, _) in
                vm.loadMbtiChange(to: vm.selectedMbti.value)
            }
            .disposed(by: disposeBag)
        
        return Output(eButtonTapped: input.eButtonTapped,
                      iButtonTapped: input.iButtonTapped,
                      nButtonTapped: input.nButtonTapped,
                      sButtonTapped: input.sButtonTapped,
                      tButtonTapped: input.tButtonTapped,
                      fButtonTapped: input.fButtonTapped,
                      jButtonTapped: input.jButtonTapped,
                      pButtonTapped: input.pButtonTapped,
                      isValidMbti: self.isValidMbti,
                      isChanged: self.isChanged,
                      selectedMbti: self.selectedMbti,
                      isMbtiChangedOverOneMonth: self.isMbtiChangedOverOneMonth,
                      mbtiChangedDate: self.mbtiChangedDate)
    }
}

extension EditMbtiViewModel {
    private func sortMbti(_ mbti: String) -> String {
        let energy = mbti.filter { $0 == "E" || $0 == "I" }
        let information = mbti.filter { $0 == "N" || $0 == "S" }
        let decision = mbti.filter { $0 == "F" || $0 == "T" }
        let lifeStyle = mbti.filter { $0 == "J" || $0 == "P" }
        return energy + information + decision + lifeStyle
    }
}

extension EditMbtiViewModel {
    
    private func loadMbtiChange(to mbti: String) {
        guard let userId = UserDefaultManager.userId else { return }
        let query = MbtiChangeQuery(user_id: userId, mbti: mbti)
        
        Task {
            let mbtiChange = try await self.settingUseCase.executeMbtiChange(query: query)
        
            if mbtiChange.code == 200 {
                self.isChanged.accept(true)
                guard let changedMbti = mbtiChange.mbti else { return }
                UserDefaultManager.mbti = changedMbti
            } 
        }
    }
}
