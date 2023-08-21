//
//  CommentIsLiked.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/21.
//

import Foundation

struct CommentIsLiked: Hashable {
    let comment_like_id: Int
    let character_id: Int
    let user_id: String
    let comment_id: Int
}
