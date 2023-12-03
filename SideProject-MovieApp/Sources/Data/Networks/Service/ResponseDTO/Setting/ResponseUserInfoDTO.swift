//
//  RequestUserInfoDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/19.
//

import Foundation

struct ResponseUserInfoDTO: Decodable {
    let code: Int
    let message: String
    let userId: String
    let nickname: String?
    let mbti: String?
    let nicknameUpdateDate: String?
    let mbtiUpdateDate: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message
        case userId = "user_id"
        case nickname, mbti
        case nicknameUpdateDate = "updated_at_nickname"
        case mbtiUpdateDate = "updated_at_mbti"
    }
}

extension ResponseUserInfoDTO {
    var toDomain: UserInfo {
        let nicknameUpdateDate = Date.stringToDate(from: nicknameUpdateDate)
        let mbtiUpdateDate = Date.stringToDate(from: mbtiUpdateDate)
        return .init(code: code,
                     message: message,
                     userId: userId,
                     nickname: nickname,
                     mbti: mbti,
                     nicknameUpdateDate: nicknameUpdateDate,
                     mbtiUpdateDate: mbtiUpdateDate)
    }
}
