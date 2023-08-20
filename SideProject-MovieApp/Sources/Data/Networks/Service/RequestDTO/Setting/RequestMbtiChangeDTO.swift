//
//  RequestMbtiChangeDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/13.
//

import Foundation

struct RequestMbtiChangeDTO: Encodable {
    let userId: String
    let mbti: String
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case mbti
    }
}
