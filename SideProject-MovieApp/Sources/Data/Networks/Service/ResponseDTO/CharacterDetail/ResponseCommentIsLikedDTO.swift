//
//  ResponseCommentIsLikedDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/21.
//

import Foundation

struct ResponseCommentIsLikedDTO: Decodable {
    let comment_like_id: Int
    let character_id: Int
    let user_id: String
    let comment_id: Int
    
    enum CodingKeys: String, CodingKey {
        case comment_like_id, character_id, user_id, comment_id
    }
}

extension ResponseCommentIsLikedDTO {
    var toDomain: CommentIsLiked {
        return .init(comment_like_id: comment_like_id, character_id: character_id, user_id: user_id, comment_id: comment_id)
    }
}
