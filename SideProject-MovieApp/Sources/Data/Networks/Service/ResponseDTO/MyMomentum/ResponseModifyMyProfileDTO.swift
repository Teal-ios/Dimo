//
//  ResponseModifyMyProfileDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/23.
//

import Foundation

struct ResponseModifyMyProfileDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String

    enum CodingKeys: String, CodingKey {
        case code, message, user_id
    }
}

extension ResponseModifyMyProfileDTO {
    var toDomain: ModifyMyProfile {
        return .init(code: code, message: message, user_id: user_id)
    }
}
