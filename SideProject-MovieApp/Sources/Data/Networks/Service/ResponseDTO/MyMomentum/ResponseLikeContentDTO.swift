//
//  ResponseLikeContentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/23.
//

import Foundation

struct ResponseLikeContentDTO: Decodable {
    let content_type: String?
    let content_id: Int
    
    enum CodingKeys: String, CodingKey {
        case content_type, content_id
    }
}
extension ResponseLikeContentDTO {
    var toDomain: LikeContent {
        return .init(content_type: content_type, content_id: content_id)
    }
}
