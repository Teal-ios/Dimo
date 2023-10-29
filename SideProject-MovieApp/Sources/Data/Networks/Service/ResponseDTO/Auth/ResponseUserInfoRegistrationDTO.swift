//
//  ResponseUserInfoRegistrationDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/10/29.
//

import Foundation

struct ResponseUserInfoRegistrationDTO: Decodable {
    let code: Int
    let message: String
    let userId: String
    
    enum CodingKeys: String, CodingKey {
        case code, message
        case userId = "user_id"
    }
}

extension ResponseUserInfoRegistrationDTO {
    var toDomain: UserInfoInSnsLogin {
        return .init(code: code, message: message, user_id: userId)
    }
}
