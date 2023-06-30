//
//  ResponseAnimationDataDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/06/28.
//

import Foundation

struct ResponseAnimationDataDTO: Codable {
    let contentId: String
    let poster: String
    let title, plot, genre, director: String
    let release, rate: String
    let characters: [ResponseCharacterDTO]
    
    enum CodingKeys: String, CodingKey {
        case contentId, poster, title, plot, genre, director, release, rate, characters
    }
}

extension ResponseAnimationDataDTO {
    var toDomain: AnimationData {
        return .init(contentId: contentId, poster: poster, title: title, plot: plot, genre: genre, director: director, release: release, rate: rate, characters: characters.map{ $0.toDomain })
    }
}
