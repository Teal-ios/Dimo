//
//  ResponseTop3MbtiDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct ResponseTop3MbtiDTO: Decodable {
    let first: [ResponseMbtiPercentDetailDTO]
    let second: [ResponseMbtiPercentDetailDTO]
    let third: [ResponseMbtiPercentDetailDTO]
    
    enum CodingKeys: String, CodingKey {
        case first, second, third
    }
}

extension ResponseTop3MbtiDTO {
    var toDomain: Top3Mbti {
        return .init(first: first.map{ $0.toDomain }, second: second.map{ $0.toDomain }, third: third.map{ $0.toDomain })
    }
}
