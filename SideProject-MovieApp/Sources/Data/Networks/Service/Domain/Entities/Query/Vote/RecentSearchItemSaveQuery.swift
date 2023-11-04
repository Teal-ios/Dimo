//
//  RecentSearchItemSaveQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/11/03.
//

import Foundation

struct RecentSearchItemSaveQuery: Hashable {
    let user_id: String
    let search_content: String
}
