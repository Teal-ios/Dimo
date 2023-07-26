//
//  ResponseLikeContentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/23.
//

import Foundation

struct ResponseLikeContentDTO: Decodable {
    let anime_id: Int
    let poster_img: String
    
    enum CodingKeys: String, CodingKey {
        case anime_id, poster_img
    }
}
extension ResponseLikeContentDTO {
    var toDomain: LikeContent {
        return .init(anime_id: anime_id, poster_img: poster_img)
    }
}
