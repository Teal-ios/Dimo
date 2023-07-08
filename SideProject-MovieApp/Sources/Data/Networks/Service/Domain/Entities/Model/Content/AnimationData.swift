//
//  AnimationData.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

// MARK: - AnimationData
struct AnimationData: Hashable {
    let contentId: String
    let poster: String
    let title, plot, genre, director: String
    let release, rate: String
    let characters: [Character]
}
