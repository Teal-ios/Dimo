//
//  DigViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/04.
//

import Foundation
import RxSwift
import RxCocoa

final class DigViewModel: ViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    private weak var coordinator: VoteCoordinator?
    private var voteUseCase: VoteUseCase
    private let characterInfo: BehaviorRelay<CharacterInfo>

    init(coordinator: VoteCoordinator?, voteUseCase: VoteUseCase, characterInfo: CharacterInfo) {
        self.coordinator = coordinator
        self.voteUseCase = voteUseCase
        self.characterInfo = BehaviorRelay(value: characterInfo)
    }
    
    struct Input{
        let nextButtonTap: ControlEvent<Void>
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
        let characterInfo: BehaviorRelay<CharacterInfo>
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
    let voteCharacterResponse = PublishRelay<VoteCharacter>()
    
    func transform(input: Input) -> Output {
        
//        input.nextButtonTap
//            .withLatestFrom(self.characterInfo)
//            .bind { [weak self] characterInfo in
//                guard let self else { return }
//                self.coordinator?.showVoteCompleteViewController(characterInfo: characterInfo)
//            }
//            .disposed(by: disposeBag)
        
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
        
        input.nextButtonTap
            .withLatestFrom(self.characterInfo)
            .bind { [weak self] characterInfo in
                guard let self else { return }
                guard let user_id = UserDefaultManager.userId else { return }
                let mbtiArray = self.mbtiStringToArray(mbti: self.mbtiString)
                guard let contentId = characterInfo.content_id else { return }
                
                 let ei = String(mbtiArray[0])
                 let sn = String(mbtiArray[1])
                 let tf = String(mbtiArray[2])
                 let jp = String(mbtiArray[3])

                self.postVoteCharacter(user_id: user_id, content_id: String(contentId), character_id: String(characterInfo.character_id), ei: ei, sn: sn, tf: tf, jp: jp)
            }
            .disposed(by: disposeBag)
        
        let voteComplete = Observable.zip(self.characterInfo, self.voteCharacterResponse)
        
        voteComplete
            .observe(on: MainScheduler.instance)
            .bind { [weak self] characterInfo, voteCharacterResponse in
                guard let self else { return }
                self.coordinator?.showVoteCompleteViewController(characterInfo: characterInfo, voteCharacter: voteCharacterResponse)
            }
            .disposed(by: disposeBag)
        
        return Output(characterInfo: self.characterInfo, eButtonTapped: input.eButtonTapped, iButtonTapped: input.iButtonTapped, nButtonTapped: input.nButtonTapped, sButtonTapped: input.sButtonTapped, tButtonTapped: input.tButtonTapped, fButtonTapped: input.fButtonTapped, jButtonTapped: input.jButtonTapped, pButtonTapped: input.pButtonTapped, mbtiValid: self.mbtiValid)
    }
}

extension DigViewModel {
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
    }
}

extension DigViewModel {
    func mbtiStringToArray(mbti: String) -> [String.Element] {
        return Array(mbti)
    }
}

extension DigViewModel {
    private func postVoteCharacter(user_id: String, content_id: String, character_id: String, ei: String, sn: String, tf: String, jp: String) {
        Task {
            let query = VoteCharacterQuery(user_id: user_id, content_id: content_id, character_id: character_id, ei: ei, sn: sn, tf: tf, jp: jp)
            
            print(query, "투표할때 보낸 쿼리")
            
            let voteCharacterResponse = try await voteUseCase.excuteVoteCharacter(query: query)
            print(voteCharacterResponse, "투표 완료")
            self.voteCharacterResponse.accept(voteCharacterResponse)
        }
    }
}
