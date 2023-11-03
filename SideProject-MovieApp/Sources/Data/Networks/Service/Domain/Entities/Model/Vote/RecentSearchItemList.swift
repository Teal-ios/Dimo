//
//  RecentSearchItemList.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct RecentSearchItemList: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let search_list: [RecentSearchItem?]
}
