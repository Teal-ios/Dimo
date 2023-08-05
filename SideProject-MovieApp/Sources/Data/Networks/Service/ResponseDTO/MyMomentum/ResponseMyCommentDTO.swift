//
//  ResponseMyCommentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct ResponseMyCommentDTO: Decodable {
    let comment_id: Int
    let review_id: Int
    let user_id: String
    let comment_like: Int
    let comment_content: String
    let comment_spoiler: Int
    let character_id: Int
    
    enum CodingKeys: String, CodingKey {
        case comment_id, review_id, user_id, comment_like, comment_content, comment_spoiler, character_id
    }
}

extension ResponseMyCommentDTO {
    var toDomain: MyComment {
        return .init(comment_id: comment_id, review_id: review_id, user_id: user_id, comment_like: comment_like, comment_content: comment_content, comment_spoiler: comment_spoiler, character_id: character_id)
    }
}
