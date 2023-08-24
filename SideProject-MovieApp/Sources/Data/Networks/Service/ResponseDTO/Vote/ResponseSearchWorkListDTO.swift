//
//  ResponseSearchWorkListDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/24.
//

import Foundation

struct ResponseSearchWorkListDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let result: [ResponseResultDTO?]
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, result
    }
}

extension ResponseSearchWorkListDTO {
    var toDomain: SearchWorkList {
        return .init(code: code, message: message, user_id: user_id, result: result.map { $0?.toDomain })
    }
}
