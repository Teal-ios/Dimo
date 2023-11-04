//
//  KakaoLogin.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct KakaoLogin: Hashable {
    let code: Int
    let message: String
    let userId: String
    let accessToken: String
    let refreshToken: String
}
