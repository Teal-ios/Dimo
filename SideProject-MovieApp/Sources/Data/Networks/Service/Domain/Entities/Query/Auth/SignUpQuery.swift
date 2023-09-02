//
//  SignUpQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

struct SignUpQuery: Hashable {
    let user_id: String
    let password: String
    let name: String
    let sns_type: String
    let agency: String
    let phone_number: String
    let nickname: String
    let mbti: String
    let push_check: Int
}
