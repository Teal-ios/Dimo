//
//  GetReviewDetailQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct GetReviewDetailQuery: Hashable {
    let user_id: String
    let character_id: Int
    let review_id: Int
}
