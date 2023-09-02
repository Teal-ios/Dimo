//
//  GetReviewDetail.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/08.
//

import Foundation

struct GetReviewDetail {
    let code: Int
    let message: String
    let user_id: String
    let character_id: String
    let review_list: [ReviewList]
    let is_liked: [ReviewIsLiked]?
}
