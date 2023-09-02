//
//  RequestLikeCommentCancelDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/26.
//

import Foundation

struct RequestLikeCommentCancelDTO: Encodable {
    let user_id: String
    let character_id: Int
    let comment_id: Int
    
    enum CodingKeys: String, CodingKey {
        case user_id, character_id, comment_id
    }
}
