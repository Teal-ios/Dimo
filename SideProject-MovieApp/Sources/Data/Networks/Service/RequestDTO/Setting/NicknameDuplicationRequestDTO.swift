//
//  RequestDuplicationIdDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/28.
//

import Foundation

struct NicknameDuplicationRequestDTO: Encodable {
    let user_id: String
    let user_nickname: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, user_nickname
    }
}
