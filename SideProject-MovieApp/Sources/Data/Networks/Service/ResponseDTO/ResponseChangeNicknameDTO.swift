//
//  ResponseChangeNicknameDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

struct ResponseChangeNicknameDTO: Codable {
    let code: Int
    let message: String
    let user_id: String
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, nickname
    }
}

extension ResponseChangeNicknameDTO {
    var toDomain: ChangeNickname {
        return .init(code: code, message: message, user_id: user_id, nickname: nickname)
    }
}
