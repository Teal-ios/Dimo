//
//  RequestCharacterAskDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/22.
//

import Foundation

struct RequestCharacterAskDTO: Encodable {
    let user_id: String
    let category: String
    let title: String
    let character_name: String
    
//    enum Codingkeys: String, CodingKey {
//        case userId = "user_id"
//        case category, title
//        case characterName = "character_name"
//    }
}
