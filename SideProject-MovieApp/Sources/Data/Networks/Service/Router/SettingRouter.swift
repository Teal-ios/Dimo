//
//  SettingRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

enum SettingRouter {
    case duplicationNickname(parameters: DuplicationNicknameQuery)
    case changeNickname(parameters: ChangeNicknameQuery)
}

extension SettingRouter: TargetType {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .duplicationNickname(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "nickname", value: parameters.user_nickname)]
        case .changeNickname(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id), URLQueryItem(name: "nickname", value: parameters.user_nickname)]
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
    
    var header: [String : String]? {
        switch self {
        case .duplicationNickname, .changeNickname:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .duplicationNickname, .changeNickname:
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
        case .duplicationNickname:
            return "/signup/is_id_dup"
        case .changeNickname:
            return "/user_info/change_nickname"
        }
    }
    
    var body: Data? {
        switch self {
        case .duplicationNickname, .changeNickname:
            return nil
        }
    }
}
