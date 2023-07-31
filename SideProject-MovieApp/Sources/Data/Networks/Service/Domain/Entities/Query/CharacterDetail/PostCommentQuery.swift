//
//  PostCommentQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct PostCommentQuery: Hashable {
    let user_id: String
    let character_id: Int
    let review_id: Int
    let comment_content: String
    let comment_spoiler: Int
}
