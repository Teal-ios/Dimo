//
//  SettingUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation


protocol SettingUseCase {
    func duplicationNicknameExcute(user_id: String, user_nickname: String) async throws -> DuplicationNickname
}

final class SettingUseCaseImpl: SettingUseCase {
    
    let settingRepository: SettingRepository
    
    init(settingRepository: SettingRepository) {
        self.settingRepository = settingRepository
    }
}

extension SettingUseCaseImpl {
    func duplicationNicknameExcute(user_id: String, user_nickname: String) async throws -> DuplicationNickname {
        let duplicationNicknameQuery = DuplicationNicknameQuery(user_id: user_id, user_nickname: user_nickname)
        
        do {
            let duplicationNickname = try await settingRepository.requestDuplicationNickname(query: duplicationNicknameQuery)
            print("응답모델", duplicationNickname)
            return duplicationNickname
        } catch {
            throw error
        }
    }
}
