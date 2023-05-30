//
//  ChangeNickname.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

struct ChangeNickname: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let nickname: String
}
