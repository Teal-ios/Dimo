//
//  ResponseMbtiContainPercentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct ResponseMbtiContainPercentDTO: Decodable {
    let mbti: String
    let percent: Int?
    
    enum CodingKeys: String, CodingKey {
        case mbti, percent
    }
}

extension ResponseMbtiContainPercentDTO {
    var toDomain: MbtiContainPercent {
        return .init(mbti: mbti, percent: percent)
    }
}
