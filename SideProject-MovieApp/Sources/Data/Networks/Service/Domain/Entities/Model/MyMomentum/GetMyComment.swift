//
//  GetMyComment.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct GetMyComment: Hashable {
    let code: Int
    let message: String
    let comment: [MyComment?]
}
