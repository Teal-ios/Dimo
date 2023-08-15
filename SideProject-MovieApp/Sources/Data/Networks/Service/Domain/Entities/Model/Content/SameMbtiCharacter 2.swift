//
//  SameMbtiCharacter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/03.
//

import Foundation

// MARK: - Character
struct SameMbtiCharacter: Hashable {
    let character_id: Int
    let anime_id: Int
    let character_img: String?
    let character_name: String
    let character_mbti: String?
}
