//
//  ModifyMyProfileQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/22.
//

import Foundation

struct ModifyMyProfileQuery: Hashable {
    let user_id: String
    let profile_img: Data?
    let intro: String?
}
