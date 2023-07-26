//
//  LikeAnimationContent.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/23.
//

import Foundation

struct LikeAnimationContent: Hashable {
    let code: Int
    let message: String
    let like_content_info: [LikeContent?]
}
