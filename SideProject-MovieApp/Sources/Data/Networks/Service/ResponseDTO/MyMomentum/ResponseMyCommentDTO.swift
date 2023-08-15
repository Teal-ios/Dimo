//
//  ResponseMyCommentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct ResponseMyCommentDTO: Decodable {
    let title: String
    let comment_id: Int
    let review_id: Int
    let user_id: String
    let comment_like: Int
    let comment_content: String
    let comment_spoiler: Int
    let character_id: Int
    let anime_id: Int
    let character_img: String
    let character_name: String
    let character_mbti: String?
    
    enum CodingKeys: String, CodingKey {
        case title, comment_id, review_id, user_id, comment_like, comment_content, comment_spoiler, character_id, anime_id, character_img, character_name, character_mbti
    }
}

extension ResponseMyCommentDTO {
    var toDomain: MyComment {
        return .init(title: title, comment_id: comment_id, review_id: review_id, user_id: user_id, comment_like: comment_like, comment_content: comment_content, comment_spoiler: comment_spoiler, character_id: character_id, anime_id: anime_id, character_img: character_img, character_name: character_name, character_mbti: character_mbti)
    }
}
