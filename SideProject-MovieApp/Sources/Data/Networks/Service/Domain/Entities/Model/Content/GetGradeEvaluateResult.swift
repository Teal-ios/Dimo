//
//  GetGradeEvaluateResult.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/20.
//

import Foundation

struct GetGradeEvaluateResult: Hashable {
    let code: Int
    let message: String
    let user_id: String
    let is_grade: IsGrade?
}
