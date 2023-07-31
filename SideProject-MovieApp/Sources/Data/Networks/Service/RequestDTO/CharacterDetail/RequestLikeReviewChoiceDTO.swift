//
//  RequestLikeReviewChoiceDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct RequestLikeReviewChoiceDTO: Encodable {
    let user_id: String
    let character_id: Int
    let review_id: Int
    
    enum CodingKeys: String, CodingKey {
        case user_id, character_id, review_id
    }
}
