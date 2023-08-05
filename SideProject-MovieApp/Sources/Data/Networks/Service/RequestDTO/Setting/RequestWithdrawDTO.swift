//
//  RequestWithdrawDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/30.
//

import Foundation

struct RequestWithdrawDTO {
    let userId: String
    let withdrawReason: String
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case withdrawReason = "drop_reason"
    }
}
