//
//  ResponseIdFindDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/11/11.
//

import Foundation

struct ResponseIdFindDTO: Decodable {
    let code: Int
    let message: String
    let userId: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, name
        case userId = "user_id"
    }
}

extension ResponseIdFindDTO {
    var toDomain: IdFind {
        return .init(code: code, message: message, user_id: userId, name: name)
    }
}
