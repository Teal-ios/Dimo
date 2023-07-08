//
//  GoogleLogin.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct GoogleLogin: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let access_token: String
    let refresh_token: String
}
