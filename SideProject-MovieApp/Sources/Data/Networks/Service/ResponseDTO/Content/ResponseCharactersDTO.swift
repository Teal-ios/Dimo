//
//  ResponseCharactersDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import Foundation

struct ResponseCharactersDTO: Decodable {
    let character_id: Int
    let character_name: String
    let character_img: String?
    let character_mbti: String?
    
    enum CodingKeys: String, CodingKey {
        case character_id, character_name, character_img, character_mbti
    }
}

extension ResponseCharactersDTO {
    var toDomain: Characters {
        return .init(character_id: character_id, character_name: character_name, character_img: character_img, character_mbti: character_mbti)
    }
}
