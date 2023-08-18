//
//  ResponseMbtiPercentDetailDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct ResponseMbtiPercentDetailDTO: Decodable {
    let mbti: String
    let ei: Int?
    let sn: Int?
    let tf: Int?
    let jp: Int?
    
    enum CodingKeys: String, CodingKey {
        case mbti, ei, sn, tf, jp
    }
}

extension ResponseMbtiPercentDetailDTO {
    var toDomain: MbtiPercentDetail {
        return .init(mbti: mbti, ei: ei, sn: sn, tf: tf, jp: jp)
    }
}
