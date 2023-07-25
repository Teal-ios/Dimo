//
//  ResponseLikeContentCheckDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import Foundation

struct ResponseLikeContentCheckDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id
    }
}

extension ResponseLikeContentCheckDTO {
    var toDomain: LikeContentCheck {
        return .init(code: code, message: message, user_id: user_id)
    }
}
