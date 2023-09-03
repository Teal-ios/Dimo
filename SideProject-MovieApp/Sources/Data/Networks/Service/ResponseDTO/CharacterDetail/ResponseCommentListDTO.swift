//
//  ResponseCommentListDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseCommentListDTO: Decodable {
    let comment_id: Int
    let review_id: Int
    let user_id: String
    let nickname: String
    let comment_like: Int
    let comment_content: String
    let comment_spoiler: Int
    let character_id: Int
    let is_liked: ResponseCommentIsLikedDTO?
    
    enum CodingKeys: String, CodingKey {
        case comment_id, review_id, user_id, nickname, comment_like, comment_content, comment_spoiler, character_id, is_liked
    }
}

extension ResponseCommentListDTO {
    var toDomain: CommentList {
        .init(comment_id: comment_id, review_id: review_id, user_id: user_id, nickname: nickname, comment_like: comment_like, comment_content: comment_content, comment_spoiler: comment_spoiler, character_id: character_id, is_liked: is_liked?.toDomain)
    }
}
