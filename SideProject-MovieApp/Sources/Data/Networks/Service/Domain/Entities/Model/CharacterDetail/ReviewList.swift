//
//  ReviewList.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ReviewList: Hashable {
    let review_id: Int
    let user_id: String
    let character_id: Int
    let review_content: String
    let review_like: Int
    let review_hits: Int
    let review_spoiler: Int
}
