//
//  MbtiChange.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/13.
//

import Foundation

struct MbtiChange {
    let code: Int
    let message: String
    let userId: String
    let mbti: String?
    
    private enum CodingKeys: String, CodingKey {
        case code, message
        case userId = "user_id"
        case mbti
    }
}
