//
//  ResponseGetEvaluateMbtiDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/20.
//

import Foundation

struct ResponseGetEvaluateMbtiDTO: Decodable {
    let code: Int
    let message: String
    let grade_best: String
    let grade_worst: String
    let content_type: String
    let contentId: String
    
    enum CodingKeys: String, CodingKey {
        case code, message, grade_best, grade_worst, content_type, contentId
    }
}

extension ResponseGetEvaluateMbtiDTO {
    var toDomain: GetEvaluateMbti {
        return .init(code: code, message: message, grade_best: grade_best, grade_worst: grade_worst, content_type: content_type, contentId: contentId)
    }
}
