//
//  ResponseReportUserDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/06.
//

import Foundation

struct ResponseReportUserDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id
    }
}

extension ResponseReportUserDTO {
    var toDomain: ReportUser {
        return .init(code: code, message: message, user_id: user_id)
    }
}
