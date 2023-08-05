//
//  Hit.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/03.
//

import Foundation

struct Hit: Hashable {
    let id: Int?
    let anime_id: Int
    let title: String
    let genre: String
    let plot: String
    let poster_img: String
    let director: String
    let anime_release: String
    let rate: String
    let hits: Int
}
