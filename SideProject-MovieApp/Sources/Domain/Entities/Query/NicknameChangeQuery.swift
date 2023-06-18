//
//  ChangeNicknameQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

struct NicknameChangeQuery: Hashable {
    let user_id: String
    let user_nickname: String
}

