//
//  SettingRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

enum SettingRouter {
    case duplicationNickname(parameters: DuplicationNicknameQuery)
}

extension SettingRouter: TargetType {
    
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
        case .duplicationNickname:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .duplicationNickname:
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
        case .duplicationNickname(let parameters):
            return "/signup/is_id_dup?user_id=\(parameters.user_id)&nickname=\(parameters.user_nickname)"
        }
    }
    
    var body: Data? {
        switch self {
        case .duplicationNickname:
            return nil
        }
    }
}
