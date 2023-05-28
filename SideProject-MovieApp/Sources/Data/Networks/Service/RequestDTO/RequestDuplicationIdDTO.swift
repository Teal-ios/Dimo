//
//  RequestDuplicationIdDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/28.
//

import Foundation

struct RequestDuplicationIdDTO: Codable {
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case user_id
    }
}
