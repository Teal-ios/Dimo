//
//  MyComment.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct MyComment: Hashable {
    let title: String
    let comment_id: Int
    let review_id: Int
    let user_id: String
    let comment_like: Int
    let comment_content: String
    let comment_spoiler: Int
    let character_id: Int
    let anime_id: Int
    let character_img: String
    let character_name: String
    let character_mbti: String?
}
