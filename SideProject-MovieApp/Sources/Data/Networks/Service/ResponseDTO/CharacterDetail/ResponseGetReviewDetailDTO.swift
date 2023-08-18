//
//  ResponseGetReviewDetailDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct ResponseGetReviewDetailDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let character_id: String
    let review_list: [ResponseReviewListDTO]
    let is_liked: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, character_id, review_list, is_liked
    }
}

extension ResponseGetReviewDetailDTO {
    var toDomain: GetReviewDetail {
        return .init(code: code, message: message, user_id: user_id, character_id: character_id, review_list: review_list.map { $0.toDomain }, is_liked: is_liked)
    }
}
