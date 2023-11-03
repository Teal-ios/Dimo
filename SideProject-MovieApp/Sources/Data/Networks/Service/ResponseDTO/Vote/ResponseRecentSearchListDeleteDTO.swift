//
//  ResponseRecentSearchListDeleteDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct ResponseRecentSearchListDeleteDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id
    }
}

extension ResponseRecentSearchListDeleteDTO {
    var toDomain: RecentSearchItemListDelete {
        return .init(code: code, message: message, user_id: user_id)
    }
}
