//
//  ResponseWithdrawDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/30.
//

import Foundation

struct ResponseWithdrawDTO: Decodable {
    let code: String
    let message: String
}

extension ResponseWithdrawDTO {
    var toDomain: Withdraw {
        return .init(code: code, message: message)
    }
}
