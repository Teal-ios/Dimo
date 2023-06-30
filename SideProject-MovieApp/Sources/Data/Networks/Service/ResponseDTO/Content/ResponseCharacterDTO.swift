//
//  ResponseCharacterDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

struct ResponseCharacterDTO: Codable {
    let characterImg, characterName: String
    
    enum CodingKeys: String, CodingKey {
        case characterImg, characterName
    }
}

extension ResponseCharacterDTO {
    var toDomain: Character {
        .init(characterImg: characterImg, characterName: characterName)
    }
}
