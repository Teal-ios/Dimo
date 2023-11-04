//
//  ResponseSeenCharacterListDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/26.
//

import Foundation

struct ResponseRecentCharacterItemDTO: Decodable {
    let recent_chr_list_id: Int
    let user_id: String
    let character_id: String
    let character_img: String
    let character_name: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case recent_chr_list_id, user_id, character_id, character_img, character_name, title
    }
}

extension ResponseRecentCharacterItemDTO {
    var toDomain: RecentCharacterItem {
        return .init(recent_chr_list_id: recent_chr_list_id, user_id: user_id, character_id: character_id, character_img: character_img, character_name: character_name, title: title)
    }
}
