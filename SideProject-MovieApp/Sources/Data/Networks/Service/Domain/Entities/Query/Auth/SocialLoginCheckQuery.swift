//
//  SocialLoginCheckQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct SocialLoginCheckQuery: Hashable {
    let user_id: String
    let sns_type: String
}
