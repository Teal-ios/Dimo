//
//  ResponseIsGradeDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/20.
//

import Foundation

struct ResponseIsGradeDTO: Decodable {
    let grade_id: Int
    let user_id: String
    let content_id: Int
    let content_type: String
    let grade: Int
    let user_mbti: String
    
    enum CodingKeys: String, CodingKey {
        case grade_id, user_id, content_id, content_type, grade, user_mbti
    }
}

extension ResponseIsGradeDTO {
    var toDomain: IsGrade {
        return .init(grade_id: grade_id, user_id: user_id, content_id: content_id, content_type: content_type, grade: grade, user_mbti: user_mbti)
    }
}
