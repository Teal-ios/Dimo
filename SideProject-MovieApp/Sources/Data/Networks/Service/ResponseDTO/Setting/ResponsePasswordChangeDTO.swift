//
//  ResponsePasswordChangeDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/11.
//

import Foundation

struct ResponsePasswordChangeDTO: Decodable {
    let code: Int
    let message: String
    let message_confirm_pw: String
    let user_id: String
}

extension ResponsePasswordChangeDTO {
    var toDomain: PasswordChange {
        return .init(code: code, message: message, message_confirm_pw: message_confirm_pw, user_id: user_id)
    }
}
