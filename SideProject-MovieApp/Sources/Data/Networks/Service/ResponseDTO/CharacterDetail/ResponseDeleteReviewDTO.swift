//
//  ResponseDeleteReviewDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseDeleteReviewDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let character_id: Int
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, character_id
    }
}

extension ResponseDeleteReviewDTO {
    var toDomain: DeleteReview {
        return .init(code: code, message: message, user_id: user_id, character_id: character_id)
    }
}
