//
//  RequestDropDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct RequestDropDTO: Codable {
    let user_id: String
    let drop_reason: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, drop_reason
    }
}
