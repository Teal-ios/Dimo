//
//  ResponseRecentSearchItemSaveDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct ResponseRecentSearchItemSaveDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let search_list: [ResponseRecentSearchItemDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, search_list
    }
}

extension ResponseRecentSearchItemSaveDTO {
    var toDomain: RecentSearchItemSave {
        return .init(code: code, message: message, user_id: user_id, search_list: search_list.map { $0?.toDomain })
    }
}
