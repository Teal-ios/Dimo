//
//  RequestUserInfoDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/19.
//

import Foundation

struct RequestUserInfoDTO: Encodable {
    let userId: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}
