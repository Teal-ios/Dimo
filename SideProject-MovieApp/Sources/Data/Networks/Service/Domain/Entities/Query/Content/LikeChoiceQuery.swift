//
//  LikeChoiceQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import Foundation

struct LikeChoiceQuery: Hashable {
    let user_id: String
    let content_type: String
    let contentId: String
}
