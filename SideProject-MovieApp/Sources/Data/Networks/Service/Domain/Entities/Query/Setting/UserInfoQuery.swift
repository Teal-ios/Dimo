//
//  UserInfoInquiryQuery.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/19.
//

import Foundation

struct UserInfoQuery: Hashable {
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}
