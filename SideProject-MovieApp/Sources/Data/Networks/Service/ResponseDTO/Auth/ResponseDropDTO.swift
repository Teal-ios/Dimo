//
//  ResponseDropDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct ResponseDropDTO: Codable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code, message
    }
}

extension ResponseDropDTO {
    var toDomain: Drop {
        return .init(message: message, code: code)
    }
}

