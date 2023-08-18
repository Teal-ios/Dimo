//
//  InquireVoteResult.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct InquireVoteResult: Hashable {
    let code: Int
    let message: String
    let content_info: [ContentInfo]
    let character_id: Int
    let mbti_percent: [MbtiPercentDetail]
    let same_vote_percent: Int?
    let my_vote_mbti: String?
    let most_vote_mbti: String?
}
