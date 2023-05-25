//
//  SignUpDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/25.
//

import Foundation

struct RequestSignUpDTO: Codable {
    let user_id: String
    let password: String
    let name: String
    let sns_type: String
    let agency: String
    let phone_number: String
    let nickname: String
    let mbti: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, password, name, sns_type, agency, phone_number, nickname, mbti
    }
}

extension RequestSignUpDTO {
    var toDomain: SignUpQuery {
        return .init(user_id: user_id, password: password, name: name, sns_type: sns_type, agency: agency, phone_number: phone_number, nickname: nickname, mbti: mbti)
    }
}
