//
//  ResponseLikeAnimationContentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/23.
//

import Foundation

struct ResponseLikeAnimationContentDTO: Decodable {
    let code: Int
    let message: String
    let like_content: [ResponseLikeContentDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, like_content
    }
}

extension ResponseLikeAnimationContentDTO {
    var toDomain: LikeAnimationContent {
        return .init(code: code, message: message, like_content: like_content.map { $0?.toDomain })
    }
}
