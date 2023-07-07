//
//  SettingUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift

protocol SettingUseCase {
    func executeNicknameDuplication(query: NicknameDuplicationQuery) async throws -> NicknameDuplication
    func executeNicknameChangeDate(query: NicknameChangeDateQuery) async throws -> NicknameChangeDate
    func executeNicknameChange(query: NicknameChangeQuery) async throws -> NicknameChange
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
    func executeNicknameChangeDate(query: NicknameChangeDateQuery) async  throws -> NicknameChangeDate {
        do {
            return try await settingRepository.fetchNicknameChangeDate(query: query)
        } catch {
            throw SettingUsecaseError.execute
        }
    }
}

extension SettingUseCaseImpl {
    func executeNicknameDuplication(query: NicknameDuplicationQuery) async throws -> NicknameDuplication {
        do {
            return try await settingRepository.fetchDuplicationNickname(query: query)
        } catch {
            throw SettingUsecaseError.execute
        }
    }
}

extension SettingUseCaseImpl {
    func executeNicknameChange(query: NicknameChangeQuery) async throws -> NicknameChange {
        do {
            return try await settingRepository.fetchNicknameChange(query: query)
        } catch {
            throw SettingUsecaseError.execute
        }
    }
}
