//
//  Result.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/30.
//

import Foundation

struct Result: Hashable {
    let character_id: Int
    let anime_id: Int
    let character_img: String
    let character_name: String
    let character_mbti: String?
    let is_vote: Int
}
