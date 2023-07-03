//
//  JoinMbtiViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/06.
//

import Foundation
import RxSwift
import RxCocoa

final class JoinMbtiViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: AuthCoordinator?
    
    
    struct Input{
        let findMbtiButtonTapped: ControlEvent<Void>
        let nextButtonTapped: ControlEvent<Void>
        let eButtonTapped: ControlEvent<Void>
        let iButtonTapped: ControlEvent<Void>
        let nButtonTapped: ControlEvent<Void>
        let sButtonTapped: ControlEvent<Void>
        let tButtonTapped: ControlEvent<Void>
        let fButtonTapped: ControlEvent<Void>
        let jButtonTapped: ControlEvent<Void>
        let pButtonTapped: ControlEvent<Void>
        let mbtiInfo: PublishRelay<[Bool]>
    }
    
    struct Output{
        let eButtonTapped: ControlEvent<Void>
        let iButtonTapped: ControlEvent<Void>
        let nButtonTapped: ControlEvent<Void>
        let sButtonTapped: ControlEvent<Void>
        let tButtonTapped: ControlEvent<Void>
        let fButtonTapped: ControlEvent<Void>
        let jButtonTapped: ControlEvent<Void>
        let pButtonTapped: ControlEvent<Void>
        let mbtiValid: PublishRelay<Bool>
    }
    
    var mbtiString = ""
    let mbtiValid = PublishRelay<Bool>()
    
    init(coordinator: AuthCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.findMbtiButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            print("Mbti 찾는 곳으로 이동")
        }.disposed(by: disposeBag)
        
        input.nextButtonTapped.bind { [weak self] _ in
            guard let self else { return }
            self.coordinator?.showJoinCompleteViewController()
        }.disposed(by: disposeBag)
        
        input.mbtiInfo.bind { [weak self] mbti in
            guard let self = self else { return }
            print(mbti)
            var count = 0
            for i in mbti {
                if i == true {
                    count += 1
                }
                if count == 4 {
                    self.mbtiDefindLogic(mbti: mbti)
                }
            }
        }
        .disposed(by: disposeBag)
        
        return Output(eButtonTapped: input.eButtonTapped
                      , iButtonTapped: input.iButtonTapped, nButtonTapped: input.nButtonTapped, sButtonTapped: input.sButtonTapped, tButtonTapped: input.tButtonTapped, fButtonTapped: input.fButtonTapped, jButtonTapped: input.jButtonTapped, pButtonTapped: input.pButtonTapped, mbtiValid: self.mbtiValid)
    }
}

extension JoinMbtiViewModel {
    private func mbtiDefindLogic(mbti: [Bool]) {
        self.mbtiString = ""
        for i in 0...mbti.count - 1 {
            if mbti[i] == true {
                switch i {
                case 0:
                    self.mbtiString += "E"
                case 1:
                    self.mbtiString += "I"
                case 2:
                    self.mbtiString += "N"
                case 3:
                    self.mbtiString += "S"
                case 4:
                    self.mbtiString += "T"
                case 5:
                    self.mbtiString += "F"
                case 6:
                    self.mbtiString += "J"
                case 7:
                    self.mbtiString += "P"
                default:
                    break
                }
            }
        }
        self.mbtiValid.accept(true)
        print(mbtiString)
    }
}
