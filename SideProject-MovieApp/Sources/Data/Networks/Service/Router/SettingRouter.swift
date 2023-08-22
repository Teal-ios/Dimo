//
//  SettingRouter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

enum SettingRouter<R> {
    case userInfo(parameters: UserInfoQuery)
    case nicknameDuplicationCheck(parameters: NicknameDuplicationQuery)
    case nicknameChange(parameters: NicknameChangeQuery)
    case nicknameChangeDateCheck(parameters: NicknameChangeDateQuery)
    case mbtiChange(parameters: MbtiChangeQuery)
    case mbtiChangeDateCheck(parameters: MbtiChangeDateQuery)
    case passwordChange(parameters: PasswordChangeQuery)
    case withdraw(paramters: WithdrawQuery)
    case characterAsk(parameters: CharacterAskQuery)
}

extension SettingRouter: TargetType2 {
 
    typealias Response = R
    
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
        case .userInfo:
            return "/user_info"
        case .nicknameDuplicationCheck:
            return "/user_info/confirm_nickname"
        case .nicknameChange:
            return "/user_info/change_nickname"
        case .nicknameChangeDateCheck:
            return "/user_info/confirm_nickname_modify"
        case .mbtiChange:
            return "/user_info/change_mbti"
        case .mbtiChangeDateCheck:
            return "/user_info/confirm_mbti_modify"
        case .passwordChange:
            return "/user_info/change_pw"
        case .withdraw:
            return "/drop"
        case .characterAsk:
            return "/admin/request_character"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .userInfo(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .nicknameDuplicationCheck(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id),
                    URLQueryItem(name: "nickname", value: parameters.user_nickname)]
        case .nicknameChange(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id),
                    URLQueryItem(name: "nickname", value: parameters.user_nickname)]
        case .nicknameChangeDateCheck(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id)]
        case .mbtiChange(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id),
                    URLQueryItem(name: "mbti", value: parameters.mbti)]
        case .mbtiChangeDateCheck(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.userId)]
        case .passwordChange(let parameters):
            return [URLQueryItem(name: "user_id", value: parameters.user_id),
                    URLQueryItem(name: "password", value: parameters.currentPassword),
                    URLQueryItem(name: "new_password", value: parameters.newPassword)]
        default:
            return nil
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var header: [String : String] {
        switch self {
        case .userInfo, .nicknameDuplicationCheck, .nicknameChange, .nicknameChangeDateCheck, .mbtiChange, .mbtiChangeDateCheck, .passwordChange, .withdraw, .characterAsk:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .withdraw(let parameters):
            let requestWithdrawDTO = RequestWithdrawDTO(userId: parameters.userId,
                         withdrawReason: parameters.withdrawReason)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestWithdrawDTO)
        case .characterAsk(let parameters):
            let requestCharacterAskDTO = RequestCharacterAskDTO(user_id: parameters.user_id,
                                                                category: parameters.category,
                                                                title: parameters.title,
                                                                character_name: parameters.character_name)
            let encoder = JSONEncoder()
            return try? encoder.encode(requestCharacterAskDTO)
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .userInfo, .nicknameDuplicationCheck, .nicknameChange, .nicknameChangeDateCheck, .mbtiChange, .mbtiChangeDateCheck, .passwordChange:
            return .get
        case .withdraw, .characterAsk:
            return .post
        }
    }
}
