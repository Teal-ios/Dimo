//
//  ResponseMostLikeChoiceMbtiDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/21.
//

import Foundation

struct ResponseMostLikeChoiceMbtiDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let most_mbti: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, most_mbti
    }
}

extension ResponseMostLikeChoiceMbtiDTO {
    var toDomain: MostLikeChoiceMbti {
        return .init(code: code, message: message, user_id: user_id, most_mbti: most_mbti)
    }
}
