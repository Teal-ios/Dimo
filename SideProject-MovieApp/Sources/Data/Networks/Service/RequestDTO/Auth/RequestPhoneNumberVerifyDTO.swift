//
//  RequestPhoneNumberVerifyDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

struct RequestPhoneNumberVerifyDTO: Codable {
    let phone_number: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case phone_number, code
    }
}
