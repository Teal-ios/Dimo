//
//  ReqeustSocialDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/07.
//

import Foundation

struct RequestSocialDTO: Codable {
    let user_id: String
    let nickname: String
    let mbti: String
    
    enum CodingKeys: String, CodingKey {
        case user_id, nickname, mbti
    }
}
