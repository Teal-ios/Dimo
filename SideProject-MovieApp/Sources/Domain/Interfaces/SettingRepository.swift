//
//  SettingRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

protocol SettingRepository: AnyObject {
    
    func fetchDuplicationNickname(query: NicknameDuplicationQuery) async throws -> NicknameDuplication
    
    func fetchChangeNickname(query: NicknameChangeQuery) async throws -> NicknameChange
}
