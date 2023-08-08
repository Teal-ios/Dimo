//
//  ResponseMyReviewDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct ResponseMyReviewDTO: Decodable {
    let title: String
    let review_id: Int
    let user_id: String
    let character_id: Int
    let review_content: String
    let review_like: Int
    let review_hits: Int
    let review_spoiler: Int
    let anime_id: Int
    let character_img: String
    let character_name: String
    let character_mbti: String?
    
    enum CodingKeys: String, CodingKey {
        case title, review_id, user_id, character_id, review_content, review_like, review_hits, review_spoiler, anime_id, character_img, character_name, character_mbti
    }
}

extension ResponseMyReviewDTO {
    var toDomain: MyReview {
        return .init(title: title, review_id: review_id, user_id: user_id, character_id: character_id, review_content: review_content, review_like: review_like, review_hits: review_hits, review_spoiler: review_spoiler, anime_id: anime_id, character_img: character_img, character_name: character_name, character_mbti: character_mbti)
    }
}
