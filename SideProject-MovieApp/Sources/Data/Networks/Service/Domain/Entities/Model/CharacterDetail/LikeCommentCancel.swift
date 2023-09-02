//
//  LikeCommentCancel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/26.
//

import Foundation

struct LikeCommentCancel: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let character_id: Int
    let comment_id: Int
}
