//
//  CommentList.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct CommentList: Hashable {
    let comment_id: Int
    let review_id: Int
    let user_id: String
    let comment_like: Int
    let comment_content: String
    let comment_spoiler: Int
    let character_id: Int
}
