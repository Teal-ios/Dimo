//
//  RequestRecentSearchSaveDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct RequestRecentSearchSaveDTO: Encodable {
    let user_id: String
    let search_content: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, search_content
    }
}
