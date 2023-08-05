//
//  ResponseHitDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/03.
//

import Foundation

struct ResponseHitDTO: Decodable {
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
    
    enum CodingKeys: String, CodingKey {
        case id, anime_id, title, genre, plot, poster_img, director, anime_release, rate, hits
    }
}

extension ResponseHitDTO {
    var toDomain: Hit {
        return .init(id: id, anime_id: anime_id, title: title, genre: genre, plot: plot, poster_img: poster_img, director: director, anime_release: anime_release, rate: rate, hits: hits)
    }
}
