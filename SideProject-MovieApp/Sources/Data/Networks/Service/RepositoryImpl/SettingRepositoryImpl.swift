//
//  SettingRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

final class SettingRepositoryImpl: SettingRepository {
    
    private let session: AsyncAwaitService
        
    init(session: AsyncAwaitService) {
        self.session = session
    }
    
}

extension SettingRepositoryImpl {
    func requestDuplicationNickname(query: DuplicationNicknameQuery) async throws -> DuplicationNickname {
        let duplicationNicknameDTO = try await session.request(target: SettingRouter.duplicationNickname(parameters: query), type: ResponseDuplicationNicknameDTO.self)
        let duplicationNickname = duplicationNicknameDTO.toDomain
        return duplicationNickname
    }
}

extension SettingRepositoryImpl {
    func requestChangeNickname(query: ChangeNicknameQuery) async throws -> ChangeNickname {
        let changeNicknameDTO = try await session.request(target: SettingRouter.changeNickname(parameters: query), type: ResponseChangeNicknameDTO.self)
        let changeNickname = changeNicknameDTO.toDomain
        return changeNickname
    }
}
