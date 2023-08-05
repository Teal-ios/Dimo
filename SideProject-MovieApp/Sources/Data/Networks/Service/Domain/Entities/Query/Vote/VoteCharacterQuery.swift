//
//  VoteCharacterQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/30.
//

import Foundation

struct VoteCharacterQuery: Hashable {
    let user_id: String
    let content_id: String
    let character_id: String
    let ei: String
    let sn: String
    let tf: String
    let jp: String
}
