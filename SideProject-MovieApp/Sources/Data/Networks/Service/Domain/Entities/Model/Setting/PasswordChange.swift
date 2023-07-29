//
//  PasswordChange.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/11.
//

import Foundation

struct PasswordChange: Hashable {
    let code: Int
    let message: String
    let message_confirm_pw: String
    let user_id: String
}
