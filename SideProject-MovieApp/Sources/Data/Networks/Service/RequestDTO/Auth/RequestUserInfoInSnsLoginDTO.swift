//
//  RequestUserInfoInSnsLoginDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/10/29.
//

import Foundation

struct RequestUserInfoInSnsLoginDTO: Encodable {
    let userId: String
    let nickname: String
    let mbti: String
    let pushCheck: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nickname, mbti
        case pushCheck = "push_check"
    }
}
