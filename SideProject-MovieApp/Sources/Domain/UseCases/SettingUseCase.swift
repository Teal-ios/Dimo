//
//  SettingUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift
import RxRelay

protocol SettingUseCase {
    func duplicationNicknameExcute(user_id: String, user_nickname: String) -> Single<DuplicationNickname>
}

final class SettingUseCaseImpl: SettingUseCase {
    
    let settingRepository: SettingRepository

    var successDuplicationNickname = PublishRelay<DuplicationNickname>()
    var errorSignal = PublishRelay<Void>()
        
    init(settingRepository: SettingRepository) {
        self.settingRepository = settingRepository
    }
}

extension SettingUseCaseImpl {
    
    func duplicationNicknameExcute(user_id: String, user_nickname: String) -> Single<DuplicationNickname> {
        let query = DuplicationNicknameQuery(user_id: user_id, user_nickname: user_nickname)
        return Single.create { single in
            let disposable = self.settingRepository.requestDuplicationNickname(query: query).subscribe { result in
                switch result {
                case .success(let duplicationNickname):
                    single(.success(duplicationNickname))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
