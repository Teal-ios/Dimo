//
//  ResponseMyVotedCharacterDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import Foundation

struct ResponseMyVotedCharacterDTO: Decodable {
    let vote_id: Int
    let character_id: Int
    let user_mbti: String
    let title: String
    let user_id: String
    let energy: String
    let recognization: String
    let prediction: String
    let reaction: String
    let content_id: Int
    let character_img: String
    let character_name: String
    let character_mbti: String
    
    enum CodingKeys: String, CodingKey {
        case vote_id, character_id, user_mbti, title, user_id, energy, recognization, prediction, reaction, content_id, character_img, character_name, character_mbti
    }
}

extension ResponseMyVotedCharacterDTO {
    var toDomain: MyVotedCharacter {
        return .init(vote_id: vote_id, character_id: character_id, user_mbti: user_mbti, title: title, user_id: user_id, energy: energy, recognization: recognization, prediction: prediction, reaction: reaction, content_id: content_id, character_img: character_img, character_name: character_name, character_mbti: character_mbti)
    }
}
