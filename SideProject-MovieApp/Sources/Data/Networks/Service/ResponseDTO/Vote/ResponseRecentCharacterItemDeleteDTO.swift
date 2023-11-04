//
//  ResponseRecentCharacterItemDeleteDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct ResponseRecentCharacterItemDeleteDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id
    }
}

extension ResponseRecentCharacterItemDeleteDTO {
    var toDomain: RecentCharacterItemDelete {
        return .init(code: code, message: message, user_id: user_id)
    }
}
