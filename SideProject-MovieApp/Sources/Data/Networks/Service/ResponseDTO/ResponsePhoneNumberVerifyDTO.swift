//
//  ResponsePhoneNumberVerifyDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

struct ResponsePhoneNumberVerifyDTO: Codable {
    let phone_valid: Bool
    
    enum CodingKeys: String, CodingKey {
        case phone_valid
    }
}

extension ResponsePhoneNumberVerifyDTO {
    var toDomain: PhoneNumberVerify {
        return .init(phone_valid: phone_valid)
    }
}
