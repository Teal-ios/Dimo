//
//  GetGradeEvaluateResultQuery.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/20.
//

import Foundation

struct GetGradeEvaluateResultQuery: Hashable {
    let user_id: String
    let contentId: String
    let content_type: String
}
