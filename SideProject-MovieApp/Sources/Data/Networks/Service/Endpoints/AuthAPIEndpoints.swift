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
    
    static func postDuplicationId(with user_id: String) -> AuthRouter<ResponseDuplicationIdDTO> {
        return AuthRouter<ResponseDuplicationIdDTO>.duplicationId(parameters: DuplicationIdQuery(user_id: user_id))
    }
}
