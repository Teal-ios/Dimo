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
    
    func executeAppleLogin(query: AppleLoginQuery) async throws -> AppleLogin
    
    func executeSocial(query: SocialQuery) async throws -> Social
    
    func executeDrop(query: DropQuery) async throws -> Drop

    func executeLogout() async throws -> Logout
    
    func executeSocialLoginCheck(query: SocialLoginCheckQuery) async throws -> SocialLoginCheck
    
    func executeUserInfoRegistration(query: UserInfoInSnsLoginQuery) async throws -> UserInfoInSnsLogin
    
    func executePhoneNumCheck(query: PhoneNumberCheckQuery) async throws -> PhoneNumberCheck
    
    func formatPhoneNumber(_ phoneNumber: String, shouldRemoveLastDigit: Bool) -> String
    
    func executeIdFind(query: IdFindQuery) async throws -> IdFind
    
    func executePasswordFind(query: PasswordFindQuery) async throws -> PasswordFind
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
    func executeAppleLogin(query: AppleLoginQuery) async throws -> AppleLogin {
        do {
            return try await authRepository.requestAppleLogin(query: query)
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
    
    func executeUserInfoRegistration(query: UserInfoInSnsLoginQuery) async throws -> UserInfoInSnsLogin {
        do {
            return try await authRepository.fetchUserInfoInSnsLogin(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
}

// MARK: ID, 비밀번호 찾기
extension AuthUseCaseImpl {
    
    func executePhoneNumCheck(query: PhoneNumberCheckQuery) async throws -> PhoneNumberCheck {
        do {
            return try await authRepository.requestPhoneNumberCheck(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
    
    func executeIdFind(query: IdFindQuery) async throws -> IdFind {
        do {
            return try await authRepository.requestIdFind(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
    
    func executePasswordFind(query: PasswordFindQuery) async throws -> PasswordFind {
        do {
            return try await authRepository.requestPasswordFind(query: query)
        } catch {
            throw AuthUseCaseError.execute
        }
    }
    
    func formatPhoneNumber(_ phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 11 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 11)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            
            if number.count <= 10 {
                number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            } else if number.count == 11 {
                number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            }
        }
        
        return number
    }
}
