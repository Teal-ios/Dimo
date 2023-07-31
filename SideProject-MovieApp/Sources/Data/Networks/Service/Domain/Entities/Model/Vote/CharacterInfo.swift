//
//  CharacterInfo.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/30.
//

import Foundation

struct CharacterInfo: Hashable {
    let character_id: Int
    let anime_id: String
    let character_img: String
    let character_name: String
    let character_mbti: String?
}
