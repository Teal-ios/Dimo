//
//  AppleLogin.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/11/04.
//

import Foundation

struct AppleLogin: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let access_token: String
    let refresh_token: String
}
