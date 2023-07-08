//
//  AuthUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

protocol AuthUseCase {
    func excuteSignUp(query: SignUpQuery) async throws -> SignUp
    
    func excutePhoneNumberCheck(query: PhoneNumberCheckQuery) async throws -> PhoneNumberCheck
    
    func excutePhoneNumberVerify(query: PhoneNumberVerifyQuery) async throws -> PhoneNumberVerify
    
    func excuteDuplicationId(user_id: String) async throws -> DuplicationId
}

enum AuthUseCaseError: String, Error {
    case execute
}

final class AuthUseCaseImpl: AuthUseCase {

    let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
}

extension AuthUseCaseImpl {
    func excuteSignUp(query: SignUpQuery) async throws -> SignUp {
        do {
            return try await authRepository.requestSignUp(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func excuteDuplicationId(user_id: String) async throws -> DuplicationId {
        do {
            return try await authRepository.fetchDuplicationId(query: DuplicationIdQuery(user_id: user_id))
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func excutePhoneNumberCheck(query: PhoneNumberCheckQuery) async throws -> PhoneNumberCheck {
        do {
            return try await authRepository.requestPhoneNumberCheck(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func excutePhoneNumberVerify(query: PhoneNumberVerifyQuery) async throws -> PhoneNumberVerify {
        do {
            return try await authRepository.requestPhoneNumberVerify(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}
