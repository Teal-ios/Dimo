//
//  RequestAppleLoginDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/11/04.
//

import Foundation

struct RequestAppleLoginDTO: Codable {
    let user_id: String
    let name: String
    let sns_type: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, name, sns_type
    }
}
