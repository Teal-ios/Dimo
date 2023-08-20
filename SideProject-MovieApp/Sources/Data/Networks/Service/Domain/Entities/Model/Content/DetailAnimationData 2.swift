//
//  DetailAnimationData.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import Foundation

struct DetailAnimationData: Hashable {
    let code: Int
    let message: String
    let contentId: String
    let title: String
    let genre: String
    let plot: String
    let poster_img: String
    let director: String
    let release: String?
    let rate: String
    let characters: [Characters]
}
