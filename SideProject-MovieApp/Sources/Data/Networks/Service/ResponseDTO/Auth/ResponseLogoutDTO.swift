//
//  ResponseLogoutDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct ResponseLogoutDTO: Codable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code, message
    }
}

extension ResponseLogoutDTO {
    var toDomain: Logout {
        return .init(code: code, message: message)
    }
}

