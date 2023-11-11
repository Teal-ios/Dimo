//
//  ResponsePasswordFindDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/11/11.
//

import Foundation

struct ResponsePasswordFindDTO: Decodable {
    let code: Int
    let message: String
    let userId: String
    let newPassword: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message
        case userId = "user_id"
        case newPassword = "new_pw"
    }
}

extension ResponsePasswordFindDTO {
    var toDomain: PasswordFind {
        return .init(code: code, message: message, user_id: userId, new_pw: newPassword)
    }
}
