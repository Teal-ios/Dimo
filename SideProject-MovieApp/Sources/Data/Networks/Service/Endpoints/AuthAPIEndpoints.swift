//
//  AuthAPIEndPoint.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct AuthAPIEndpoints {
    static func postSignUp(with requestDTO: RequestSignUpDTO) -> AuthRouter<ResponseSignUpDTO> {
        return AuthRouter<ResponseSignUpDTO>.signup(parameters: SignUpQuery(user_id: requestDTO.user_id, password: requestDTO.password, name: requestDTO.name, sns_type: requestDTO.sns_type, agency: requestDTO.agency, phone_number: requestDTO.phone_number, nickname: requestDTO.nickname, mbti: requestDTO.mbti))
    }
    
    static func postPhoneNumberVerify(with requestDTO: RequestPhoneNumberVerifyDTO) -> AuthRouter<ResponsePhoneNumberVerifyDTO> {
        return AuthRouter<ResponsePhoneNumberVerifyDTO>.phoneNumberVerify(parameters: PhoneNumberVerifyQuery(phone_number: requestDTO.phone_number, code: requestDTO.code))
    }
    
    static func postPhoneNumberCheck(with requestDTO: RequestPhoneNumberCheckDTO) -> AuthRouter<ResponsePhoneNumberCheckDTO> {
        return AuthRouter<ResponsePhoneNumberCheckDTO>.phoneNumberCheck(parameters: PhoneNumberCheckQuery(phone_number: requestDTO.phone_number))
    }
    
    static func getDuplicationId(with user_id: String) -> AuthRouter<ResponseDuplicationIdDTO> {
        return AuthRouter<ResponseDuplicationIdDTO>.duplicationId(parameters: DuplicationIdQuery(user_id: user_id))
    }
    
    static func postLogin(with requestDTO: RequestLoginDTO) -> AuthRouter<ResponseLoginDTO> {
        return AuthRouter<ResponseLoginDTO>.login(parameters: LoginQuery(user_id: requestDTO.user_id, password: requestDTO.password))
    }
    
    static func postKakaoLogin(with requestDTO: RequestKakaoLoginDTO) -> AuthRouter<ResponseKakaoLoginDTO> {
        return AuthRouter<ResponseKakaoLoginDTO>.kakaoLogin(parameters: KakaoLoginQuery(user_id: requestDTO.user_id, name: requestDTO.name, sns_type: requestDTO.sns_type))
    }
    
    static func postGoogleLogin(with requestDTO: RequestGoogleLoginDTO) -> AuthRouter<ResponseGoogleLoginDTO> {
        return AuthRouter<ResponseGoogleLoginDTO>.googleLogin(parameters:  GoogleLoginQuery(user_id: requestDTO.user_id, name: requestDTO.name, sns_type: requestDTO.sns_type))
    }
    
    static func postSocial(with requestDTO: RequestSocialDTO) -> AuthRouter<ResponseSocialDTO> {
        return AuthRouter<ResponseSocialDTO>.social(parameters:  SocialQuery(user_id: requestDTO.user_id, nickname: requestDTO.nickname, mbti: requestDTO.mbti))
    }
    
    static func postDrop(with requestDTO: RequestDropDTO) -> AuthRouter<ResponseDropDTO> {
        return AuthRouter<ResponseDropDTO>.drop(parameters: DropQuery(user_id: requestDTO.user_id, drop_reason: requestDTO.drop_reason))
    }
    
    static func getLogout() -> AuthRouter<ResponseLogoutDTO> {
        return AuthRouter<ResponseLogoutDTO>.logout
    }
    
    static func getSocialLoginCheck(user_id: String, sns_type: String) -> AuthRouter<ResponseSocialLoginCheckDTO> {
        return AuthRouter<ResponseSocialLoginCheckDTO>.socialLoginCheck(parameters: SocialLoginCheckQuery(user_id: user_id, sns_type: sns_type))
    }
}

