//
//  SettingRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift

enum SettingRepositoryError: Error {
    case request
}

final class SettingRepositoryImpl: SettingRepository {

    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension SettingRepositoryImpl {
    func fetchDuplicationNickname(query: NicknameDuplicationQuery) async throws -> NicknameDuplication {
        let requestDTO = RequestNicknameDuplicationDTO(user_id: query.user_id, user_nickname: query.user_nickname)
        let target = APIEndpoints.getNicknameDuplicationInfo(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
}

extension SettingRepositoryImpl {
    func fetchChangeNickname(query: NicknameChangeQuery) async throws -> NicknameChange {
        let requestDTO = RequestNicknameChangeDTO(user_id: query.user_id, user_nickname: query.user_nickname)
        let target = APIEndpoints.postNicknameChange(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
}
