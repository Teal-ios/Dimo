//
//  ResponseMbtiChangeDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/13.
//

import Foundation

struct ResponseMbtiChangeDTO: Decodable {
    let code: Int
    let message: String
    let userId: String
    let mbti: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message
        case userId = "user_id"
        case mbti
    }
}

extension ResponseMbtiChangeDTO {
    var toDomain: MbtiChange {
        return .init(code: code, message: message, userId: userId, mbti: mbti)
    }
}
