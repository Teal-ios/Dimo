//
//  ResponseCharacterInfoDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseCharacterInfoDTO: Decodable {
    let character_id: Int
    let content_id: Int?
    let anime_id: Int?
    let character_img: String
    let character_name: String
    let character_mbti: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case character_id, content_id, anime_id, character_img, character_name, character_mbti, title
    }
}

extension ResponseCharacterInfoDTO {
    var toDomain: CharacterInfo {
        return .init(character_id: character_id, content_id: content_id, anime_id: anime_id, character_img: character_img, character_name: character_name, character_mbti: character_mbti, title: title)
    }
}

