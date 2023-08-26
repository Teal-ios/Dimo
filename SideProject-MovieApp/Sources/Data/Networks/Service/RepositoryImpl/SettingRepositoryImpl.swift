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

// MARK: 닉네임 변경
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
    
    func fetchNicknameChange(query: NicknameChangeQuery) async throws -> NicknameChange {
        let requestDTO = RequestNicknameChangeDTO(user_id: query.user_id, user_nickname: query.user_nickname)
        let target = APIEndpoints.postNicknameChange(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
    
    func fetchNicknameChangeDate(query: NicknameChangeDateQuery) async throws -> NicknameChangeDate {
        let requestDTO = RequestNicknameChangeDateDTO(user_id: query.user_id)
        let target = APIEndpoints.getNicknameChangeDate(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
}

// MARK: 패스워드 변경
extension SettingRepositoryImpl {
    
    func fetchPasswordChange(query: PasswordChangeQuery) async throws -> PasswordChange {
        let requestDTO = RequestPasswordChangeDTO(user_id: query.user_id,
                                                  password: query.currentPassword,
                                                  new_password: query.newPassword)
        let target = APIEndpoints.getPasswordChange(with: requestDTO)
        do {
            let data = try await dataTransferService.request(with: target)
            print("🔥 PASSWORD CHANGE TARGET: \(target)")
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
}

//MARK: 회원탈퇴
extension SettingRepositoryImpl {
    
    func fetchWithdraw(query: WithdrawQuery) async throws -> Withdraw {
        let requestDTO = RequestWithdrawDTO(userId: query.userId,
                                            withdrawReason: query.withdrawReason)
        let target = APIEndpoints.postWithdraw(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
}

//MARK: Mbti 변경
extension SettingRepositoryImpl {
    
    func fetchMbtiChange(query: MbtiChangeQuery) async throws -> MbtiChange {
        let requestDTO = RequestMbtiChangeDTO(userId: query.user_id,
                                              mbti: query.mbti)
        let target = APIEndpoints.getMbtiChange(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
}

// MARK: 유저정보 조회
extension SettingRepositoryImpl {
    func fetchUserInfo(query: UserInfoQuery) async throws -> UserInfo {
        let requestDTO = RequestUserInfoDTO(userId: query.user_id)
        let target = APIEndpoints.getUserInfo(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
}

// MARK: 캐릭터 요청
extension SettingRepositoryImpl {
    func fetchCharacterName(query: CharacterAskQuery) async throws -> CharacterAsk {
        let requestDTO = RequestCharacterAskDTO(user_id: query.user_id, category: query.category, title: query.title, character_name: query.character_name)
        let target = APIEndpoints.postCharacterAsk(with: requestDTO)
        print("⭐️ FETCH CHARCTER TARGET: \(target)")
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw SettingRepositoryError.request
        }
    }
}
