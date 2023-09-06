//
//  RequestPostReportUserDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/06.
//

import Foundation

struct RequestPostReportUserDTO: Encodable {
    let user_id: String
    let review_id: Int
    let report_reason: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, review_id, report_reason
    }
}
