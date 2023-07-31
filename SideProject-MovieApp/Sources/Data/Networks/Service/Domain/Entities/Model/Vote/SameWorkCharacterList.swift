//
//  SameWorkCharacterList.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/30.
//

import Foundation

struct SameWorkCharacterList: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let result: [Result?]
}
