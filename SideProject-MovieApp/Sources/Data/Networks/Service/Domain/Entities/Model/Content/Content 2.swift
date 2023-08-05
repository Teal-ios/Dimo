//
//  Content.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/03.
//

import Foundation

struct Content: Hashable {
    let category: String
    let represent: [Hit]?
    let same_mbti_anime: [Hit]?
    let same_mbti_char: [SameMbtiCharacter]?
    let recommend: [Hit]?
    let hit: [Hit]?
}
