//
//  ResponseAppleLoginDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/11/04.
//

import Foundation

struct ResponseAppleLoginDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let access_token: String
    let refresh_token: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, access_token, refresh_token
    }
}

extension ResponseAppleLoginDTO {
    var toDomain: AppleLogin {
        return .init(code: code, message: message, user_id: user_id, access_token: access_token, refresh_token: refresh_token)
    }
}
