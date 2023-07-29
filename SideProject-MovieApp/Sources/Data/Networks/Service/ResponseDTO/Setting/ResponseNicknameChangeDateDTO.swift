//
//  ResponseNicknameChangeDateDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/30.
//

import Foundation

struct ResponseNicknameChangeDateDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
}

extension ResponseNicknameChangeDateDTO {
    var toDomain: NicknameChangeDate {
        return .init(code: code, message: message, user_id: user_id)
    }
}
    