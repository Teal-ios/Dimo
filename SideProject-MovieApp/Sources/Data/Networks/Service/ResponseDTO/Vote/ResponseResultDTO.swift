//
//  ResponseResultDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseResultDTO: Decodable {
    let character_id: Int
    let anime_id: Int
    let character_img: String
    let character_name: String
    let character_mbti: String?

    enum CodingKeys: String, CodingKey {
        case character_id, anime_id, character_img, character_name, character_mbti
    }
}

extension ResponseResultDTO {
    var toDomain: Result {
        .init(character_id: character_id, anime_id: anime_id, character_img: character_img, character_name: character_name, character_mbti: character_mbti)
    }
}

