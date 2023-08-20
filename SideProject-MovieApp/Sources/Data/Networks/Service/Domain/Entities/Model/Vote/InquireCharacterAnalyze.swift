//
//  InquireCharacterAnalyze.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct InquireCharacterAnalyze: Hashable {
    let code: Int
    let message: String
    let character_info: [CharacterInfo]
    let mbti_percent: [MbtiPercentDetail]
    let my_vote_mbti: String?
    let my_vote_mbti_percent: Int?
    let top3_mbti: Top3Mbti
}
