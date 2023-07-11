//
//  RequestPasswordChangeDTO.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/07/11.
//

import Foundation

struct RequestPasswordChangeDTO: Encodable {
    let user_id: String
    let password: String
    let new_password: String
}
