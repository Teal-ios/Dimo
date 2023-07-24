//
//  ResponseDetailAnimationDataDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/24.
//

import Foundation

struct ResponseDetailAnimationDataDTO: Decodable {
    let code: Int
    let message: String
    let contentId: String
    let title: String
    let genre: String
    let plot: String
    let poster_img: String
    let director: String
    let release: String
    let rate: String
    let characters: [ResponseCharactersDTO]
    
    enum CodingKeys: String, CodingKey {
        case code, message, contentId, title, genre, plot, poster_img, director, release, rate, characters
    }
}

extension ResponseDetailAnimationDataDTO {
    var toDomain: DetailAnimationData {
        return .init(code: code, message: message, contentId: contentId, title: title, genre: genre, plot: plot, poster_img: poster_img, director: director, release: release, rate: rate, characters: characters.map { $0.toDomain })
    }
}
