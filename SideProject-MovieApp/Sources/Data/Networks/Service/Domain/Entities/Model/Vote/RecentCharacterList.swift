//
//  RecentCharacterItemList.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/10/26.
//

import Foundation

struct RecentCharacterList: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let seen_chr_list: [RecentCharacterItem?]
}
