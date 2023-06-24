//
//  APIEndpoints.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/06/21.
//

import Foundation

struct APIEndpoints {
    
    static func getNicknameDuplicationInfo(with requestDTO: RequestNicknameDuplicationDTO) -> SettingRouter<ResponseNicknameDuplicationDTO> {
        return SettingRouter<ResponseNicknameDuplicationDTO>.nicknameDuplicationCheck(parameters: NicknameDuplicationQuery(user_id: requestDTO.user_id,user_nickname: requestDTO.user_nickname))
    }
    
    static func postNicknameChange(with requestDTO: RequestNicknameChangeDTO) -> SettingRouter<ResponseNicknameChangeDTO> {
        return SettingRouter<ResponseNicknameChangeDTO>.nicknameChange(parameters: NicknameChangeQuery(user_id: requestDTO.user_id, user_nickname: requestDTO.user_nickname))
    }
}
