//
//  ResponseRecentSearchItemDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct ResponseRecentSearchItemDTO: Decodable {
    let search_id: Int
    let user_id: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case search_id, user_id, content
    }
}

extension ResponseRecentSearchItemDTO {
    var toDomain: RecentSearchItem {
        return .init(search_id: search_id, user_id: user_id, content: content)
    }
}
