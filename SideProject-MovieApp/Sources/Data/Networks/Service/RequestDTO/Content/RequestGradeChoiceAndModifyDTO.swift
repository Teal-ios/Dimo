//
//  RequestGradeChoiceAndModifyDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import Foundation

struct RequestGradeChoiceAndModifyDTO: Codable {
    let user_id: String
    let contentId: String
    let content_type: String
    let grade: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, contentId, content_type, grade
    }
}
