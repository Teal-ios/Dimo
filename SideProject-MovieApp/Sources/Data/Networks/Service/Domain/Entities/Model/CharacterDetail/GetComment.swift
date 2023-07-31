//
//  GetComment.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct GetComment: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let comment_list: [CommentList?]
}
