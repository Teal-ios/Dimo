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
    let like_content_info: [ResponseLikeContentDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, like_content_info
    }
}

extension ResponseLikeAnimationContentDTO {
    var toDomain: LikeAnimationContent {
        return .init(code: code, message: message, like_content_info: like_content_info.map { $0?.toDomain })
    }
}
