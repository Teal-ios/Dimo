//
//  GetEvaluateMbti.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/20.
//

import Foundation

struct GetEvaluateMbti: Hashable {
    let code: Int
    let message: String
    let grade_best: String
    let grade_worst: String
    let content_type: String
    let contentId: String
}
