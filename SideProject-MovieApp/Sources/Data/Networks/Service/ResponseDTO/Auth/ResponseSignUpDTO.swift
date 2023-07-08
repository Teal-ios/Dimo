//
//  ResponseSignUpDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct ResponseSignUpDTO: Codable {
    let code: Int
    let message: String
    let user_id: String
    let refresh_token: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, refresh_token
    }
}

extension ResponseSignUpDTO {
    var toDomain: SignUp {
        return .init(code: code, message: message, user_id: user_id, refresh_token: refresh_token)
    }
}

