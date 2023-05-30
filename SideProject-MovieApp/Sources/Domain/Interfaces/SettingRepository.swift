//
//  SettingRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

protocol SettingRepository: AnyObject {
    
    func requestDuplicationNickname(query: DuplicationNicknameQuery) async throws -> DuplicationNickname
    
    func requestChangeNickname(query: ChangeNicknameQuery) async throws -> ChangeNickname
}
