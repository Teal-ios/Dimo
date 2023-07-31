//
//  ResponseRandomCharacterRecommendListDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseRandomCharacterRecommendListDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let character_info: [ResponseCharacterInfoDTO]
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, character_info
    }
}

extension ResponseRandomCharacterRecommendListDTO {
    var toDomain: RandomCharacterRecommendList {
        return .init(code: code, message: message, user_id: user_id, character_info: character_info.map { $0.toDomain })
    }
}
