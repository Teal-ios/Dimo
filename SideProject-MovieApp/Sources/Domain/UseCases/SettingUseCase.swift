//
//  SettingUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift

protocol SettingUseCase {
    func executeNicknameDuplication(query: NicknameDuplicationQuery) -> Observable<NicknameDuplication>
    
    func executeNicknameChange(query: NicknameChangeQuery) -> Observable<NicknameChange>
}

enum SettingUsecaseError: String, Error {
    case execute
}

final class SettingUseCaseImpl: SettingUseCase {

    private let settingRepository: SettingRepository

    init(settingRepository: SettingRepository) {
        self.settingRepository = settingRepository
    }
}

extension SettingUseCaseImpl {
    func executeNicknameDuplication(query: NicknameDuplicationQuery) -> Observable<NicknameDuplication> {
        let nicknameDuplicationObservable: Observable<NicknameDuplication> = Observable.create { observer in
            let task = Task {
                let nicknameDuplication = try await self.settingRepository.fetchDuplicationNickname(query: query)
                observer.on(.next(nicknameDuplication))
                observer.on(.completed)
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
        
        return nicknameDuplicationObservable
    }
}

extension SettingUseCaseImpl {
    func executeNicknameChange(query: NicknameChangeQuery) -> Observable<NicknameChange> {
        let nicknameChangeObservable: Observable<NicknameChange> = Observable.create { observer in
            let task = Task {
                let nicknameChange = try await self.settingRepository.fetchChangeNickname(query: query)
                observer.on(.next(nicknameChange))
                observer.on(.completed)
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
            
        return nicknameChangeObservable
    }
}
