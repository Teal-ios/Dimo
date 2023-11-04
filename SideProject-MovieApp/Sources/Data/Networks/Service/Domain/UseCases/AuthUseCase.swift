//
//  AuthUseCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

protocol AuthUseCase {
    func executeSignUp(query: SignUpQuery) async throws -> SignUp
    
    func executePhoneNumberCheck(query: PhoneNumberCheckQuery) async throws -> PhoneNumberCheck
    
    func executePhoneNumberVerify(query: PhoneNumberVerifyQuery) async throws -> PhoneNumberVerify
    
    func executeDuplicationId(user_id: String) async throws -> DuplicationId
    
    func executeLogin(query: LoginQuery) async throws -> Login
    
    func executeKakaoLogin(query: KakaoLoginQuery) async throws -> KakaoLogin
    
    func executeGoogleLogin(query: GoogleLoginQuery) async throws -> GoogleLogin
    
    func executeSocial(query: SocialQuery) async throws -> Social
    
    func executeDrop(query: DropQuery) async throws -> Drop

    func executeLogout() async throws -> Logout
    
    func executeSocialLoginCheck(query: SocialLoginCheckQuery) async throws -> SocialLoginCheck
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
    func executeSignUp(query: SignUpQuery) async throws -> SignUp {
        do {
            return try await authRepository.requestSignUp(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executeDuplicationId(user_id: String) async throws -> DuplicationId {
        do {
            return try await authRepository.fetchDuplicationId(query: DuplicationIdQuery(user_id: user_id))
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executePhoneNumberCheck(query: PhoneNumberCheckQuery) async throws -> PhoneNumberCheck {
        do {
            return try await authRepository.requestPhoneNumberCheck(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executePhoneNumberVerify(query: PhoneNumberVerifyQuery) async throws -> PhoneNumberVerify {
        do {
            return try await authRepository.requestPhoneNumberVerify(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executeLogin(query: LoginQuery) async throws -> Login {
        do {
            return try await authRepository.requestLogin(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executeKakaoLogin(query: KakaoLoginQuery) async throws -> KakaoLogin {
        do {
            return try await authRepository.requestKakaoLogin(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executeGoogleLogin(query: GoogleLoginQuery) async throws -> GoogleLogin {
        do {
            return try await authRepository.requestGoogleLogin(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executeSocial(query: SocialQuery) async throws -> Social {
        do {
            return try await authRepository.requestSocial(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executeDrop(query: DropQuery) async throws -> Drop {
        do {
            return try await authRepository.requestDrop(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executeLogout() async throws -> Logout {
        do {
            return try await authRepository.fetchLogout()
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

extension AuthUseCaseImpl {
    func executeSocialLoginCheck(query: SocialLoginCheckQuery) async throws -> SocialLoginCheck {
        do {
            return try await authRepository.fetchSocialLoginCheck(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}
