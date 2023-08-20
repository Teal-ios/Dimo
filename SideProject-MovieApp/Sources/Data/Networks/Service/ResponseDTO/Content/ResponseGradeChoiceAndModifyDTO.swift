//
//  ResponseGradeChoiceAndModifyDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import Foundation

struct ResponseGradeChoiceAndModifyDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String

    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id
    }
}

extension ResponseGradeChoiceAndModifyDTO {
    var toDomain: GradeChoiceAndModify {
        return .init(code: code, message: message, user_id: user_id)
    }
}
