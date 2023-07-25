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
    let grade_message: String?
    let user_id: String
    let content_type: String
    let contentId: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, grade_message, user_id, content_type, contentId
    }
}

extension ResponseGradeChoiceAndModifyDTO {
    var toDomain: GradeChoiceAndModify {
        return .init(code: code, message: message, grade_message: grade_message, user_id: user_id, content_type: content_type, contentId: contentId)
    }
}
