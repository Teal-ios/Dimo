//
//  ResponseSameMbtiCharacterDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/03.
//

import Foundation

// MARK: - Character
struct ResponseSameMbtiCharacterDTO: Decodable {
    let character_id: Int
    let anime_id: Int
    let character_name: String
    let character_img: String?
    let character_mbti: String?
    let title: String
    
    enum Codingkeys: String, CodingKey {
        case character_id, anime_id, character_name, character_img, character_mbti, title
    }
}

extension ResponseSameMbtiCharacterDTO {
    var toDomain: SameMbtiCharacter {
        return .init(character_id: character_id, anime_id: anime_id, character_img: character_img, character_name: character_name, character_mbti: character_mbti, title: title)
    }
}
