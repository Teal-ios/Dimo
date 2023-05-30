//
//  ResponseDuplicationNicknameDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

struct ResponseDuplicationNicknameDTO: Codable {
    let code: Int
    let message: String
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id
    }
}

extension ResponseDuplicationNicknameDTO {
    var toDomain: DuplicationNickname {
        return .init(code: code, message: message, user_id: user_id)
    }
}
