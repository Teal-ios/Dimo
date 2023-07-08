//
//  PhoneNumberVerifyQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

struct PhoneNumberVerifyQuery: Hashable {
    let phone_number: String
    let code: String
}
