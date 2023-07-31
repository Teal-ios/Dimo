//
//  ResponseModifyReviewDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseModifyReviewDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let character_id: Int
    let review_id: Int
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, character_id, review_id
    }
}

extension ResponseModifyReviewDTO {
    var toDomain: ModifyReview {
        return .init(code: code, message: message, user_id: user_id, character_id: character_id, review_id: review_id)
    }
}
