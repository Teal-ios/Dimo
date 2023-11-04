//
//  KakaoLoginQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct KakaoLoginQuery: Hashable {
    let userId: String
    let name: String
    let snsType: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case snsType = "sns_type"
    }
}
