//
//  ResponseGetGradeEvaluateResultDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/20.
//

import Foundation

struct ResponseGetGradeEvaluateResultDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let is_grade: ResponseIsGradeDTO
    
    enum CodingKeys: String, CodingKey {
        case  code, message, user_id, is_grade
    }
}

extension ResponseGetGradeEvaluateResultDTO {
    var toDomain: GetGradeEvaluateResult {
        return .init(code: code, message: message, user_id: user_id, is_grade: is_grade.toDomain)
    }
}
