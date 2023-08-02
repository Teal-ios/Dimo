//
//  ResponseGetMyCommentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct ResponseGetMyCommentDTO: Decodable {
    let code: Int
    let message: String
    let comment: [ResponseMyCommentDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, comment
    }
}

extension ResponseGetMyCommentDTO {
    var toDomain: GetMyComment {
        return .init(code: code, message: message, comment: comment.map{ $0?.toDomain })
    }
}
