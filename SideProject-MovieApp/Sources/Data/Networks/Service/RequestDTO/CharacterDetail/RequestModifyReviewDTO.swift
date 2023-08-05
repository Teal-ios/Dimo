//
//  RequestModifyReviewDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct RequestModifyReviewDTO: Encodable {
    let user_id: String
    let character_id: Int
    let review_content: String
    let review_spoiler: Int
    let review_id: Int
    
    enum CodingKeys: String, CodingKey {
        case user_id, character_id, review_content, review_spoiler, review_id
    }
}
