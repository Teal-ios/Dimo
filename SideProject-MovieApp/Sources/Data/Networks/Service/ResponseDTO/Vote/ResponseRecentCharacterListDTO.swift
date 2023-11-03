//
//  ResponseRecentSearchCharacterListDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/26.
//

import Foundation

struct ResponseRecentCharacterListDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let seen_chr_list: [ResponseRecentCharacterItemDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, seen_chr_list
    }
}

extension ResponseRecentCharacterListDTO {
    var toDomain: RecentCharacterItemList {
        return .init(code: code, message: message, user_id: user_id, seen_chr_list: seen_chr_list.map { $0?.toDomain })
    }
}
