//
//  AuthRepositoryImpl.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

enum AuthRepositoryError: Error {
    case request
}

final class AuthRepositoryImpl: AuthRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension AuthRepositoryImpl {
    func requestSignUp(query: SignUpQuery) async throws -> SignUp {
        let requestDTO = RequestSignUpDTO(user_id: query.user_id, password: query.password, name: query.name, sns_type: query.sns_type, agency: query.agency, phone_number: query.phone_number, nickname: query.nickname, mbti: query.mbti)
        
        let target = AuthAPIEndpoints.postSignUp(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func requestPhoneNumberCheck(query: PhoneNumberCheckQuery) async throws -> PhoneNumberCheck {
        let requestDTO = RequestPhoneNumberCheckDTO(phone_number: query.phone_number)
        let target = AuthAPIEndpoints.postPhoneNumberCheck(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func requestPhoneNumberVerify(query: PhoneNumberVerifyQuery) async throws -> PhoneNumberVerify {
        let requestDTO = RequestPhoneNumberVerifyDTO(phone_number: query.phone_number, code: query.code)
        let target = AuthAPIEndpoints.postPhoneNumberVerify(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func fetchDuplicationId(query: DuplicationIdQuery) async throws -> DuplicationId {
        let target = AuthAPIEndpoints.postDuplicationId(with: query.user_id)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}
