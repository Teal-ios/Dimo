//
//  RequestPostBlindReviewDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/06.
//

import Foundation

struct RequestPostBlindReviewDTO: Encodable {
    let user_id: String
    let review_id: Int
    let blind_type: Int
    
    enum CodingKeys: String, CodingKey {
        case user_id, review_id, blind_type
    }
}
