//
//  ResponseContentInfoDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/18.
//

import Foundation

struct ResponseContentInfoDTO: Decodable {
    let title: String
    let character_img: String
    let character_name: String
    let character_mbti: String?
    
    enum CodingKeys: String, CodingKey {
        case title, character_img, character_name, character_mbti
    }
}

extension ResponseContentInfoDTO {
    var toDomain: ContentInfo {
        .init(title: title, character_img: character_img, character_name: character_name, character_mbti: character_mbti)
    }
}
