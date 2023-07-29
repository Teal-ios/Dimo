//
//  GradeChoiceAndModifyQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/25.
//

import Foundation

struct GradeChoiceAndModifyQuery: Hashable {
    let user_id: String
    let contentId: String
    let content_type: String
    let grade: String
}
