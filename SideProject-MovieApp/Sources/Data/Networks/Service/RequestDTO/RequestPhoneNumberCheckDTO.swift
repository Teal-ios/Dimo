//
//  RequestPhoneNumberCheckDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

struct RequestPhoneNumberCheckDTO: Codable {
    let phone_number: String
    
    enum CodingKeys: String, CodingKey {
        case phone_number
    }
}
//
//extension RequestPhoneNumberCheckDTO {
//    var toDomain: PhoneNumberCheckQuery {
//        return .init(phone_number: phone_number)
//    }
//}
