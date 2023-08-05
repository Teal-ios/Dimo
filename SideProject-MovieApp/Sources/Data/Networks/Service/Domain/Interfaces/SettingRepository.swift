//
//  SettingRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation

protocol SettingRepository: AnyObject {
    
    func fetchDuplicationNickname(query: NicknameDuplicationQuery) async throws -> NicknameDuplication
    
    func fetchNicknameChange(query: NicknameChangeQuery) async throws -> NicknameChange
    
    func fetchNicknameChangeDate(query: NicknameChangeDateQuery) async throws -> NicknameChangeDate
    
    func fetchPasswordChange(query: PasswordChangeQuery) async throws -> PasswordChange
    
    func fetchWithdraw(query: WithdrawQuery) async throws -> Withdraw
}
