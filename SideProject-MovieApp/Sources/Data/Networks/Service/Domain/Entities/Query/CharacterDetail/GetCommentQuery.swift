//
//  GetCommentQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct GetCommentQuery: Hashable {
    let user_id: String
    let review_id: Int
}
