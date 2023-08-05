//
//  RequestRandomCharacterRecommendDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct RequestRandomCharacterRecommendDTO: Encodable {
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case user_id
    }
}
