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
}

extension AuthRouter: TargetType2 {
    var header: [String : String] {
        switch self {
        case .signup, .phoneNumberCheck, .phoneNumberVerify, .duplicationId:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    
    typealias Response = R
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .duplicationId(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        default:
            return nil
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
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signup, .phoneNumberCheck, .phoneNumberVerify:
            return .post
        case .duplicationId:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
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
        }
    }
    
    var body: Data? {
        switch self {
            
        case .signup(let parameters):
            let reqeustSignUpDTO = RequestSignUpDTO(user_id: parameters.user_id, password: parameters.password, name: parameters.name, sns_type: parameters.sns_type, agency: parameters.agency, phone_number: parameters.phone_number, nickname: parameters.nickname, mbti: parameters.mbti)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(reqeustSignUpDTO)
            
        case .phoneNumberCheck(let parameters):
            let requestPhoneNumberCheckDTO = RequestPhoneNumberCheckDTO(phone_number: parameters.phone_number)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestPhoneNumberCheckDTO)
            
        case .phoneNumberVerify(let parameters):
            let requestPhoneNumberVerifyDTO = RequestPhoneNumberVerifyDTO(phone_number: parameters.phone_number, code: parameters.code)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(requestPhoneNumberVerifyDTO)
            
        case .duplicationId:
            return nil
        }
    }
}
