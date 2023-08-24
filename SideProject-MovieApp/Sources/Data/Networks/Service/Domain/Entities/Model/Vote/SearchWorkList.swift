//
//  SearchWorkList.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/24.
//

import Foundation

struct SearchWorkList: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let result: [Result?]
}
