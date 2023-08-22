//
//  ResponseCharacterAskDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/23.
//

import Foundation

struct ResponseCharacterAskDTO: Decodable {
    let code: Int
    let message: String
    let userId: String
    
    enum CodingKeys: String, CodingKey {
        case code, message
        case userId = "user_id"
    }
}

extension ResponseCharacterAskDTO {
    var toDomain: CharacterAsk {
        .init(code: code, message: message, user_id: userId)
    }
}
