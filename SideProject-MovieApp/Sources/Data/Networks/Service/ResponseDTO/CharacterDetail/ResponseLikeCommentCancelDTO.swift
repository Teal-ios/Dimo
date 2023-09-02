//
//  ResponseLikeCommentCancelDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/26.
//

import Foundation

struct ResponseLikeCommentCancelDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let character_id: Int
    let comment_id: Int
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, character_id, comment_id
    }
}

extension ResponseLikeCommentCancelDTO {
    var toDomain: LikeCommentCancel {
        return .init(code: code, message: message, user_id: user_id, character_id: character_id, comment_id: comment_id)
    }
}
