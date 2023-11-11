//
//  ResponsePhoneNumberCheckDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//
import Foundation

struct ResponsePhoneNumberCheckDTO: Decodable {
    let msg: String
    
    enum CodingKeys: String, CodingKey {
        case msg
    }
}

extension ResponsePhoneNumberCheckDTO {
    var toDomain: PhoneNumberCheck {
        return .init(msg: msg)
    }
}
