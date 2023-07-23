//
//  NicknameChangeRequestDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/24.
//

import Foundation

struct RequestNicknameChangeDTO: Encodable {
    let user_id: String
    let user_nickname: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, user_nickname
    }
}
