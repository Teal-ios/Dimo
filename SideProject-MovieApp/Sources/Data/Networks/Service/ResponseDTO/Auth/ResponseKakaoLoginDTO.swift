//
//  ResponseKakaoLoginDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct ResponseKakaoLoginDTO: Codable {
    let code: Int
    let message: String
    let user_id: String
    let access_token: String
    let refresh_token: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, access_token, refresh_token
    }
}

extension ResponseKakaoLoginDTO {
    var toDomain: KakaoLogin {
        return .init(code: code, message: message, user_id: user_id, access_token: access_token, refresh_token: refresh_token)
    }
}
