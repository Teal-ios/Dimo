//
//  ResponseInquireCharacterAnalyzeDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct ResponseInquireCharacterAnalyzeDTO: Decodable {
    let code: Int
    let message: String
    let character_info: [ResponseCharacterInfoDTO]
    let mbti_percent: [ResponseMbtiPercentDetailDTO]
    let my_vote_mbti: String?
    let my_vote_mbti_percent: Int?
    let top3_mbti: ResponseTop3MbtiDTO
    
    enum CodingKeys: String, CodingKey {
        case code, message, character_info, mbti_percent, my_vote_mbti, my_vote_mbti_percent, top3_mbti
    }
}

extension ResponseInquireCharacterAnalyzeDTO {
    var toDOmain: InquireCharacterAnalyze {
        return .init(code: code, message: message, character_info: character_info.map { $0.toDomain }, mbti_percent: mbti_percent.map { $0.toDomain }, my_vote_mbti: my_vote_mbti, my_vote_mbti_percent: my_vote_mbti_percent, top3_mbti: top3_mbti.toDomain)
    }
}
