//
//  ResponseReviewIsLikeDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/26.
//

import Foundation

struct ResponseReviewIsLikeDTO: Decodable {
    let review_like_id: Int
    let character_id: Int
    let user_id: String
    let review_id: Int
    
    enum CodingKeys: String, CodingKey {
        case review_like_id, character_id, user_id, review_id
    }
}

extension ResponseReviewIsLikeDTO {
    var toDomain: ReviewIsLiked {
        return .init(review_like_id: review_like_id, character_id: character_id, user_id: user_id, review_id: review_id)
    }
}
