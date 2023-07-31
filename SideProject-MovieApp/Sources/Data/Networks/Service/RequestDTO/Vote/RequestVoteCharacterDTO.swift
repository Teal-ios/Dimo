//
//  RequestVoteCharacterDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct RequestVoteCharacterDTO: Hashable {
    let user_id: String
    let content_id: String
    let character_id: String
    let ei: String
    let sn: String
    let tf: String
    let jp: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, content_id, character_id, ei, sn, tf, jp
    }
}
