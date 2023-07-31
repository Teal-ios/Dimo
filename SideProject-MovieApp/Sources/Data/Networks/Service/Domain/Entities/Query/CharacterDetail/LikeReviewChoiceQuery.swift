//
//  LikeReviewChoiceQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct LikeReviewChoiceQuery: Hashable {
    let user_id: String
    let character_id: Int
    let review_id: Int
}
