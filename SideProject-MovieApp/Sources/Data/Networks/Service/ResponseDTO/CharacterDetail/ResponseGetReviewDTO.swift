//
//  ResponseGetReviewDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseGetReviewDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let review_list: [ResponseReviewListDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, review_list
    }
}

extension ResponseGetReviewDTO {
    var toDomain: GetReview {
        return .init(code: code, message: message, user_id: user_id, review_list: review_list.map { $0?.toDomain })
    }
}
