//
//  ResponseMyProfileDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/23.
//

import Foundation

struct ResponseMyProfileDTO: Decodable {
    let code: Int
    let message: String
    let user_id: String
    let name: String
    let nickname: String
    let mbti: String
    let intro: String?
    let profile_img: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message, user_id, name, nickname, mbti, intro, profile_img
    }
}

extension ResponseMyProfileDTO {
    var toDomain: MyProfile {
        return .init(code: code, message: message, user_id: user_id, name: name, nickname: nickname, mbti: mbti, intro: intro, profile_img: profile_img)
    }
}
