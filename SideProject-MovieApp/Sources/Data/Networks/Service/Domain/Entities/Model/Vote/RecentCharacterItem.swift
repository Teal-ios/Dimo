//
//  RecentCharacterItem.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/21.
//

import Foundation

struct RecentCharacterItem: Hashable {
    let recent_chr_list_id: Int
    let user_id: String
    let character_id: String
    let character_img: String
    let character_name: String
    let title: String
}
