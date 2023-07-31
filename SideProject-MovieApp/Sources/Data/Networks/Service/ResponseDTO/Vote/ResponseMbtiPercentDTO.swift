//
//  ResponseMbtiPercentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseMbtiPercentDTO: Decodable {
    let ei: Int?
    let sn: Int?
    let tf: Int?
    let jp: Int?

    enum CodingKeys: String, CodingKey {
        case ei, sn, tf, jp
    }
}

extension ResponseMbtiPercentDTO {
    var toDomain: MbtiPercent {
        return .init(ei: ei, sn: sn, tf: tf, jp: jp)
    }
}
