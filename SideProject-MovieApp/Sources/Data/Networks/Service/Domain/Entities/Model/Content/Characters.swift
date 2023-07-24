//
//  Characters.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import Foundation

// MARK: - Character
struct Characters: Hashable {
    let character_id: Int
    let character_name: String
    let character_img: String?
    let character_mbti: String?
}
