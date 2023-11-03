//
//  RequestRecentCharacterSaveDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct RequestRecentCharacterSaveDTO: Encodable {
    let user_id: String
    let character_id: Int
    
    enum CodingKeys: String, CodingKey {
        case user_id, character_id
    }
}
