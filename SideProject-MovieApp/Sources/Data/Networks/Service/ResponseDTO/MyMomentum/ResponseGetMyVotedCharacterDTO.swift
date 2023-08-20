//
//  ResponseGetMyVotedCharacterDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import Foundation

struct ResponseGetMyVotedCharacterDTO: Decodable {
    let code: Int
    let message: String
    let voted_character: [ResponseMyVotedCharacterDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, voted_character
    }
}

extension ResponseGetMyVotedCharacterDTO {
    var toDomain: GetMyVotedCharacter {
        return .init(code: code, message: message, voted_character: voted_character.map { $0?.toDomain })
    }
}
