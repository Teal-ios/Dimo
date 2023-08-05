//
//  GetMyReview.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/01.
//

import Foundation

struct GetMyReview: Hashable {
    let code: Int
    let message: String
    let review: [MyReview?]
}
