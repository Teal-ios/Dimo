//
//  ResponseInquireVoteResultDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct ResponseInquireVoteResultDTO: Decodable {
    let code: Int
    let message: String
    let content_info: [ResponseContentInfoDTO]
    let character_id: Int
    let mbti_percent: [ResponseMbtiPercentDetailDTO]
    let same_vote_percent: Int?
    let my_vote_mbti: String?
    let most_vote_mbti: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message, content_info, character_id, mbti_percent, same_vote_percent, my_vote_mbti, most_vote_mbti
    }
}

extension ResponseInquireVoteResultDTO {
    var toDomain: InquireVoteResult {
        return .init(code: code, message: message, content_info: content_info.map{ $0.toDomain }, character_id: character_id, mbti_percent: mbti_percent.map { $0.toDomain }, same_vote_percent: same_vote_percent, my_vote_mbti: my_vote_mbti, most_vote_mbti: most_vote_mbti)
    }
}
