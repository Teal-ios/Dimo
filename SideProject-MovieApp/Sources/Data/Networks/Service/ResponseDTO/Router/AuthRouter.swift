//
//  Router.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/14.
//

import Foundation

enum AuthRouter {
    case signup(parameters: SignUpQuery)
}

extension AuthRouter: TargetType {
    
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return APIKey.baseURL
    }
    
    var header: [String : String]? {
        switch self {
        case .signup:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signup:
            return .post
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

        }
    }
    
    var body: Data? {
        switch self {
            
        case .signup(let parameters):
            let reqeustSignUpDTO = RequestSignUpDTO(user_id: parameters.user_id, password: parameters.password, name: parameters.name, sns_type: parameters.sns_type, agency: parameters.agency, phone_number: parameters.phone_number, nickname: parameters.nickname, mbti: parameters.mbti)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(reqeustSignUpDTO)
            
        }
    }
}
