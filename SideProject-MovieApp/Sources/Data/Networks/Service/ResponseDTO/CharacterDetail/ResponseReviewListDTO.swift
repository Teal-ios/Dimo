//
//  ResponseReviewListDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseReviewListDTO: Decodable {
    let review_id: Int
    let user_id: String
    let character_id: Int
    let review_content: String
    let review_like: Int
    let review_hits: Int
    let review_spoiler: Int
    
    enum CodingKeys: String, CodingKey {
        case review_id, user_id, character_id, review_content, review_like, review_hits, review_spoiler
    }
}

extension ResponseReviewListDTO {
    var toDomain: ReviewList {
        return .init(review_id: review_id, user_id: user_id, character_id: character_id, review_content: review_content, review_like: review_like, review_hits: review_hits, review_spoiler: review_spoiler)
    }
}
