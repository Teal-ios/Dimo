//
//  RequestLoginDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct RequestLoginDTO: Encodable {
    let user_id: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, password
    }
}
