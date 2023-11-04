//
//  RequestRecentSearchListDeleteDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct RequestRecentSearchListDeleteDTO: Encodable {
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case user_id
    }
}
