//
//  ResponseTop3MbtiDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct ResponseTop3MbtiDTO: Decodable {
    let first: ResponseMbtiContainPercentDTO
    let second: ResponseMbtiContainPercentDTO
    let third: ResponseMbtiContainPercentDTO
    
    enum CodingKeys: String, CodingKey {
        case first, second, third
    }
}

extension ResponseTop3MbtiDTO {
    var toDomain: Top3Mbti {
        return .init(first: first.toDomain, second: second.toDomain, third: third.toDomain)
    }
}
