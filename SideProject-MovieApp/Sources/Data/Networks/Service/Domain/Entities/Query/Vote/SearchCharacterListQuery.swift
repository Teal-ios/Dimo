//
//  SearchCharacterListQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/30.
//

import Foundation

struct SearchCharacterListQuery: Hashable {
    let user_id: String
    let search_content: String
}
