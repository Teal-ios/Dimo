//
//  RequestIdFindDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/11/11.
//

import Foundation

struct RequestPasswordFindDTO: Encodable {
    let userId: String
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case phoneNumber = "phone_number"
    }
}
