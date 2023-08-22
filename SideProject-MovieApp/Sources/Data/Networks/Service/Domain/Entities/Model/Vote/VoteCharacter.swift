//
//  VoteCharacter.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/30.
//

import Foundation

struct VoteCharacter: Hashable {
    let code: Int
    let message: String
    let contentId: String?
    let content_title: String?
    let character_id: String?
    let character_mbti: String?
    let mbti_percent: MbtiPercent?
}
