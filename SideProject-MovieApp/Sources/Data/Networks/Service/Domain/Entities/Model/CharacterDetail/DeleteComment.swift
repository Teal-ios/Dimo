//
//  DeleteComment.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/21.
//

import Foundation

struct DeleteComment: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let character_id: Int
    let review_id: Int
}
