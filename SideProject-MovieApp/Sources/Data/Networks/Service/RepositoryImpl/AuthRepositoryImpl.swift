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
        let requestDTO = RequestSignUpDTO(user_id: query.user_id, password: query.password, name: query.name, sns_type: query.sns_type, agency: query.agency, phone_number: query.phone_number, nickname: query.nickname, mbti: query.mbti, push_check: query.push_check)
        
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
        let target = AuthAPIEndpoints.getDuplicationId(with: query.user_id)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func requestLogin(query: LoginQuery) async throws -> Login {
        let requestDTO = RequestLoginDTO(user_id: query.user_id, password: query.password)
        let target = AuthAPIEndpoints.postLogin(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func requestKakaoLogin(query: KakaoLoginQuery) async throws -> KakaoLogin {
        let requestDTO = RequestKakaoLoginDTO(user_id: query.userId, name: query.name, sns_type: query.snsType)
        let target = AuthAPIEndpoints.postKakaoLogin(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func requestGoogleLogin(query: GoogleLoginQuery) async throws -> GoogleLogin {
        let requestDTO = RequestGoogleLoginDTO(user_id: query.user_id, name: query.name, sns_type: query.sns_type)
        let target = AuthAPIEndpoints.postGoogleLogin(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func requestSocial(query: SocialQuery) async throws -> Social {
        let requestDTO = RequestSocialDTO(user_id: query.user_id, nickname: query.nickname, mbti: query.mbti)
        let target = AuthAPIEndpoints.postSocial(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func requestDrop(query: DropQuery) async throws -> Drop {
        let requestDTO = RequestDropDTO(user_id: query.user_id, drop_reason: query.drop_reason)
        let target = AuthAPIEndpoints.postDrop(with: requestDTO)
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func fetchLogout() async throws -> Logout {
        let target = AuthAPIEndpoints.getLogout()
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}

extension AuthRepositoryImpl {
    func fetchSocialLoginCheck(query: SocialLoginCheckQuery) async throws -> SocialLoginCheck {
        let target = AuthAPIEndpoints.getSocialLoginCheck(user_id: query.userId, sns_type: query.snsType)
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
    
    func fetchUserInfoInSnsLogin(query: UserInfoInSnsLoginQuery) async throws -> UserInfoInSnsLogin {
        let requestDTO = RequestUserInfoInSnsLoginDTO(userId: query.user_id, nickname: query.nickname, mbti: query.mbti, pushCheck: query.push_check)
        let target = AuthAPIEndpoints.postUserInfoInSnsLogin(with: requestDTO  )
        
        do {
            let data = try await dataTransferService.request(with: target)
            return data.toDomain
        } catch {
            throw AuthRepositoryError.request
        }
    }
}
