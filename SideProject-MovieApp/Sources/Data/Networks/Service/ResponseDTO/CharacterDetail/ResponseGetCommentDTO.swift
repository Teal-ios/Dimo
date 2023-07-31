//
//  ResponseGetCommentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct ResponseGetCommentDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let comment_list: [ResponseCommentListDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, comment_list
    }
}

extension ResponseGetCommentDTO {
    var toDomain: GetComment {
        return .init(code: code, message: message, user_id: user_id, comment_list: comment_list.map { $0?.toDomain })
    }
}
