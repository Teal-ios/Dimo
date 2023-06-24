//
//  APIEndpoints.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/21.
//

import Foundation

struct APIEndpoints {
    
    static func getNicknameDuplicationInfo(with nicknameDuplicationRequestDTO: NicknameDuplicationRequestDTO) -> SettingRouter<NicknameDuplicationResponseDTO> {
        return SettingRouter<NicknameDuplicationResponseDTO>.nicknameDuplicationCheck(parameters: NicknameDuplicationQuery(user_id: nicknameDuplicationRequestDTO.user_id,user_nickname: nicknameDuplicationRequestDTO.user_nickname))
    }
    
}
