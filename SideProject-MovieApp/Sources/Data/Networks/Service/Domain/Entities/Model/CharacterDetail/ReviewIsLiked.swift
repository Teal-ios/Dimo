//
//  ReviewIsLiked.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/26.
//

import Foundation

struct ReviewIsLiked: Hashable {
    let review_like_id: Int
    let character_id: Int
    let user_id: String
    let review_id: Int
}
