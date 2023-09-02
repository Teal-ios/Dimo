//
//  LikeCommentCancelQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/26.
//

import Foundation

struct LikeCommentCancelQuery: Hashable {
    let user_id: String
    let character_id: Int
    let comment_id: Int
}
