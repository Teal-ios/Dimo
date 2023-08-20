//
//  SettingUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift

protocol SettingUseCase {
    func executeUserInfo(query: UserInfoQuery) async throws -> UserInfo
    func executeNicknameDuplication(query: NicknameDuplicationQuery) async throws -> NicknameDuplication
    func executeNicknameChangeDate(query: NicknameChangeDateQuery) async throws -> NicknameChangeDate
    func executeNicknameChange(query: NicknameChangeQuery) async throws -> NicknameChange
    func executePasswordChange(query: PasswordChangeQuery) async throws -> PasswordChange
    func executeWithdraw(query: WithdrawQuery) async throws -> Withdraw
    func executeMbtiChange(query: MbtiChangeQuery) async throws -> MbtiChange
}

enum SettingUseCaseError: String, Error {
    case execute
}

final class SettingUseCaseImpl: SettingUseCase {

    private let settingRepository: SettingRepository

    init(settingRepository: SettingRepository) {
        self.settingRepository = settingRepository
    }
}

// MARK: Nickname Change
extension SettingUseCaseImpl {
    func executeNicknameChangeDate(query: NicknameChangeDateQuery) async  throws -> NicknameChangeDate {
        do {
            return try await settingRepository.fetchNicknameChangeDate(query: query)
        } catch {
            throw SettingUseCaseError.execute
        }
    }
    
    func executeNicknameDuplication(query: NicknameDuplicationQuery) async throws -> NicknameDuplication {
        do {
            return try await settingRepository.fetchDuplicationNickname(query: query)
        } catch {
            throw SettingUseCaseError.execute
        }
    }
    
    func executeNicknameChange(query: NicknameChangeQuery) async throws -> NicknameChange {
        do {
            return try await settingRepository.fetchNicknameChange(query: query)
        } catch {
            throw SettingUseCaseError.execute
        }
    }
}

// MARK: Password Change
extension SettingUseCaseImpl {
    func executePasswordChange(query: PasswordChangeQuery) async throws -> PasswordChange {
        do {
            return try await settingRepository.fetchPasswordChange(query: query)
        } catch {
            throw SettingUseCaseError.execute
        }
    }
}

// MARK: Withdraw
extension SettingUseCaseImpl {
    func executeWithdraw(query: WithdrawQuery) async throws -> Withdraw {
        do {
            return try await settingRepository.fetchWithdraw(query: query)
        } catch {
            throw SettingUseCaseError.execute
        }
    }
}

// MARK: MBTI Change
extension SettingUseCaseImpl {
    func executeMbtiChange(query: MbtiChangeQuery) async throws -> MbtiChange {
        do {
            return try await settingRepository.fetchMbtiChange(query: query)
        } catch {
            throw SettingUseCaseError.execute
        }
    }
    
//    func executeMbtiChangeDate(query: MbtiChangeDateQuery) async throws -> MbtiChangeDate {
//        do {
//
//        } catch {
//
//        }
//    }
}

// MARK: Request UserInfo
extension SettingUseCaseImpl {
    func executeUserInfo(query: UserInfoQuery) async throws -> UserInfo {
        do {
            return try await settingRepository.fetchUserInfo(query: query)
        } catch {
            throw SettingUseCaseError.execute
        }
    }
}
