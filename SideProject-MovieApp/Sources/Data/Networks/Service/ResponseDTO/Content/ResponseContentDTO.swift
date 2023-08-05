//
//  ResponseContentDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/03.
//

import Foundation

struct ResponseContentDTO: Decodable {
    let category: String
    let represent: [ResponseHitDTO]?
    let same_mbti_anime: [ResponseHitDTO]?
    let same_mbti_char: [ResponseSameMbtiCharacterDTO]?
    let recommend: [ResponseHitDTO]?
    let hit: [ResponseHitDTO]?
    
    enum Codingkeys: String, CodingKey {
        case category, represent, same_mbti_anime, same_mbti_char, recommend, hit
    }
}

extension ResponseContentDTO {
    var toDomain: Content {
        return .init(category: category, represent: represent?.map { $0.toDomain }, same_mbti_anime: same_mbti_anime?.map { $0.toDomain }, same_mbti_char: same_mbti_char?.map{ $0.toDomain }, recommend: recommend?.map{ $0.toDomain }, hit: hit?.map { $0.toDomain })
    }
}
