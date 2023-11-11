//
//  Router.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import Foundation

enum AuthRouter<R> {
    case signup(parameters: SignUpQuery)
    case phoneNumberCheck(parameters: PhoneNumberCheckQuery)
    case phoneNumberVerify(parameters: PhoneNumberVerifyQuery)
    case duplicationId(parameters: DuplicationIdQuery)
    case login(parameters: LoginQuery)
    case kakaoLogin(parameters: KakaoLoginQuery)
    case googleLogin(parameters: GoogleLoginQuery)
    case appleLogin(parameters: AppleLoginQuery)
    case social(parameters: SocialQuery)
    case logout
    case drop(parameters: DropQuery)
    case socialLoginCheck(parameters: SocialLoginCheckQuery)
    case userInfoRegistration(parameters: UserInfoInSnsLoginQuery)
    case idFind(parameters: IdFindQuery)
    case passwordFind(parameters: PasswordFindQuery)
}

extension AuthRouter: TargetType2 {
    
    typealias Response = R

    var header: [String : String] {
        switch self {
        case .signup, .phoneNumberCheck, .phoneNumberVerify, .duplicationId, .login, .kakaoLogin, .googleLogin, .appleLogin, .social, .logout, .drop, .socialLoginCheck, .userInfoRegistration, .idFind, .passwordFind:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var port: Int {
        return 3000
    }
    
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return APIKey.baseURL
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/signup"
        case .phoneNumberCheck:
            return "/signup/phone-check"
        case .phoneNumberVerify:
            return "/signup/phone-check/verify"
        case .duplicationId:
            return "/signup/is_id_dup"
        case .login:
            return  "/login"
        case .kakaoLogin:
            return "/social/kakao_login"
        case .googleLogin:
            return "/social/google_login"
        case .appleLogin:
            return "/social/apple_login"
        case .social:
            return "/social"
        case .logout:
            return "/logout"
        case .drop:
            return "/drop"
        case .socialLoginCheck:
            return "/social/check"
        case .userInfoRegistration:
            return "/social"
        case .idFind:
            return "/login/find_id"
        case .passwordFind:
            return "/login/find_pw"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .duplicationId(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .socialLoginCheck(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.userId), URLQueryItem(name: "sns_type", value: parameters.snsType)]
        case .idFind(let parameters):
            return [URLQueryItem(name: "name", value: parameters.name),
                    URLQueryItem(name: "agency", value: parameters.agency),
                    URLQueryItem(name: "phone_number", value: parameters.phone_number),
                    URLQueryItem(name: "ver_code", value: parameters.ver_code)]
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signup, .phoneNumberCheck, .phoneNumberVerify, .login, .kakaoLogin, .googleLogin, .appleLogin, .social, .drop, .userInfoRegistration, .passwordFind:
            return .post
        case .duplicationId, .logout, .socialLoginCheck, .idFind:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var body: Data? {
        switch self {
            
        case .signup(let parameters):
            let requestSignUpDTO = RequestSignUpDTO(user_id: parameters.user_id, password: parameters.password, name: parameters.name, sns_type: parameters.sns_type, agency: parameters.agency, phone_number: parameters.phone_number, nickname: parameters.nickname, mbti: parameters.mbti, push_check: parameters.push_check)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestSignUpDTO)
            
        case .phoneNumberCheck(let parameters):
            let requestPhoneNumberCheckDTO = RequestPhoneNumberCheckDTO(phoneNumber: parameters.phone_number)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestPhoneNumberCheckDTO)
            
        case .phoneNumberVerify(let parameters):
            let requestPhoneNumberVerifyDTO = RequestPhoneNumberVerifyDTO(phone_number: parameters.phone_number, code: parameters.code)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestPhoneNumberVerifyDTO)
            
        case .login(let parameters):
            let requestLoginDTO = RequestLoginDTO(user_id: parameters.user_id, password: parameters.password)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestLoginDTO)
        case .duplicationId:
            return nil
            
        case .kakaoLogin(let parameters):
            let requestKakaoLoginDTO = RequestKakaoLoginDTO(user_id: parameters.userId, name: parameters.name, sns_type: parameters.snsType)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestKakaoLoginDTO)
            
        case .googleLogin(let parameters):
            let requestGoogleLoginDTO = RequestGoogleLoginDTO(user_id: parameters.user_id, name: parameters.name, sns_type: parameters.sns_type)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestGoogleLoginDTO)
            
        case .appleLogin(let parameters):
            let requestAppleLoginDTO = RequestAppleLoginDTO(user_id: parameters.user_id, name: parameters.name, sns_type: parameters.sns_type)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestAppleLoginDTO)
            
        case .social(let parameters):
            let requestSocialDTO = RequestSocialDTO(user_id: parameters.user_id, nickname: parameters.nickname, mbti: parameters.mbti)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestSocialDTO)
            
        case .logout:
            return nil
            
        case .drop(let parameters):
            let requestDropDTO = RequestDropDTO(user_id: parameters.user_id, drop_reason: parameters.drop_reason)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestDropDTO)
            
        case .socialLoginCheck:
            return nil
            
        case .userInfoRegistration(let parameters):
            let requestDTO = RequestUserInfoInSnsLoginDTO(userId: parameters.user_id, nickname: parameters.nickname, mbti: parameters.mbti, pushCheck: parameters.push_check)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
            
        case .idFind:
            return nil
            
        case .passwordFind(let parameters):
            let requestDTO = RequestPasswordFindDTO(userId: parameters.user_id,
                                                    phoneNumber: parameters.phone_number)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestDTO)
        }
        
    }
}
