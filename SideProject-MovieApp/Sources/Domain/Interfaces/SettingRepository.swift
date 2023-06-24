//
//  SettingRepository.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/30.
//

import Foundation
import RxSwift

protocol SettingRepository: AnyObject {
    
    func requestDuplicationNickname(query: NicknameDuplicationQuery) -> NicknameDuplication
    
    func requestChangeNickname(query: NicknameChangeQuery) -> NicknameChange
}
