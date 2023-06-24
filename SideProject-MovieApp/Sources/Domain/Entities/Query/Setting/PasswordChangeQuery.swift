//
//  PasswordChangeQuery.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/19.
//

import Foundation

struct PasswordChangeQuery: Hashable {
    let user_id: String
    let password: String
}
