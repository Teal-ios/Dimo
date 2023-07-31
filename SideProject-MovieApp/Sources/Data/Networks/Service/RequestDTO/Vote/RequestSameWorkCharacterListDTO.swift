//
//  RequestSameWorkCharacterListDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/31.
//

import Foundation

struct RequestSameWorkCharacterListDTO: Hashable {
    let user_id: String
    let search_content: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, search_content
    }
}
