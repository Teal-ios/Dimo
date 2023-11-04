//
//  ResponseKakaoLoginDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct ResponseKakaoLoginDTO: Decodable {
    let code: Int
    let message: String
    let userId: String
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case code, message
        case userId = "user_id"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

extension ResponseKakaoLoginDTO {
    var toDomain: KakaoLogin {
        return .init(code: code, message: message, userId: userId, accessToken: accessToken, refreshToken: refreshToken)
    }
}
