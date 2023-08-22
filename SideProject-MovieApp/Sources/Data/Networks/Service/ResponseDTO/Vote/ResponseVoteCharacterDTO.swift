//
//  ResponseVoteCharacterDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseVoteCharacterDTO: Decodable {
    let code: Int
    let message: String
    let contentId: String?
    let content_title: String?
    let character_id: String?
    let character_mbti: String?
    let mbti_percent: ResponseMbtiPercentDTO?

    enum CodingKeys: String, CodingKey {
        case code, message, contentId, content_title, character_id, character_mbti, mbti_percent
    }
}

extension ResponseVoteCharacterDTO {
    var toDomain: VoteCharacter {
        .init(code: code, message: message, contentId: contentId, content_title: content_title, character_id: character_id, character_mbti: character_mbti, mbti_percent: mbti_percent?.toDomain)
    }
}
