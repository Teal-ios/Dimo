//
//  MyProfile.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/23.
//

import Foundation

struct MyProfile: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let name: String
    let nickname: String
    let mbti: String
    let intro: String?
    let profile_img: String?
}
