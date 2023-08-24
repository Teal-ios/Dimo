//
//  SearchWorkListQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/24.
//

import Foundation

struct SearchWorkListQuery: Hashable {
    let user_id: String
    let search_content: String
}
