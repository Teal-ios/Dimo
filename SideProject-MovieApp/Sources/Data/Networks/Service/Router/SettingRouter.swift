//
//  SettingRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

enum SettingRouter {
    case duplicationNickname(parameters: NicknameDuplicationQuery)
    case changeNickname(parameters: NicknameChangeQuery)
}

enum SettingRouter2<R> {
//    case userInfoInquiry(parameter: NicknameDuplicationQuery)
//    case nicknameDuplicationCheck(parameter: )
//    case nicknameChange(parameter: NicknameChangeQuery)
//    case nicknameChangeDateCheck
//    case mbtiChange
//    case mbtiChangeDateCheck
//    case passwordChange
}

//extension SettingRouter2: TargetType2 {
// 
//    typealias Response = R
//    
//    var port: Int {
//        return 3000
//    }
//    
//    var scheme: String {
//        return "http"
//    }
//    
//    var host: String {
//        return APIKey.baseURL
//    }
//    
//    var path: String {
//        switch self {
//        case .userInfoInquiry:
//            return "/user_info"
//        case .nicknameDuplicationCheck:
//            return "/user_info/confirm_nickname"
//        case .nicknameChange:
//            return "/user_info/change_nickname"
//        case .nicknameChangeDateCheck:
//            return ""
//        case .mbtiChange:
//            return "/user_info/change_mbti"
//        case .mbtiChangeDateCheck:
//            return ""
//        case .passwordChange:
//            return "/user_info/change_pw"
//        }
//    }
//    
//    var queryItems: [URLQueryItem] {
//        switch self {
//        case .userInfoInquiry:
//            return "/user_info"
//        case .nicknameDuplicationCheck:
//            return "/user_info/confirm_nickname"
//        case .nicknameChange:
//            return "/user_info/change_nickname"
//        case .nicknameChangeDateCheck:
//            return ""
//        case .mbtiChange:
//            return "/user_info/change_mbti"
//        case .mbtiChangeDateCheck:
//            return ""
//        case .passwordChange:
//            return "/user_info/change_pw"
//        }
//    }
//    
//    var parameters: String? {
//        return nil
//    }
//    
//    var header: [String : String] {
//        switch self {
//        case .userInfoInquiry, .nicknameDuplicationCheck, .nicknameChange, .nicknameChangeDateCheck, .mbtiChange, .mbtiChangeDateCheck, .passwordChange:
//            return ["accept" : "application/json" , "Content-Type": "application/json"]
//        }
//    }
//    
//    var body: Data? {
//        return nil
//    }
//    
//    var httpMethod: HTTPMethod {
//        return .get
//    }
//}

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
            return "/user_info/confirm_nickname"
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
