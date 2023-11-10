//
//  RequestModifyMyProfileDTO.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/23.
//

import Foundation

struct RequestModifyMyProfileDTO: Encodable {
    let user_id: String
    let profile_img: Data?
    let intro: String?
    
    enum CodingKeys: String, CodingKey {
        case user_id, profile_img, intro
    }
}
