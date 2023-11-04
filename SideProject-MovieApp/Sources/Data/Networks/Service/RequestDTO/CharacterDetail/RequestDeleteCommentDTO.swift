//
//  RequestDeleteCommentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/21.
//

import Foundation

struct RequestDeleteCommentDTO: Encodable {
    let user_id: String
    let character_id: Int
    let review_id: Int
    let comment_id: Int
    
    enum CodingKeys: String, CodingKey {
        case user_id, character_id, review_id, comment_id
    }
}
