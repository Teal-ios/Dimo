//
//  MyReview.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct MyReview: Hashable {
    let title: String
    let review_id: Int
    let user_id: String
    let character_id: Int
    let review_content: String
    let review_like: Int
    let review_hits: Int
    let review_spoiler: Int
    let anime_id: Int
    let character_img: String
    let character_name: String
    let character_mbti: String?
}
