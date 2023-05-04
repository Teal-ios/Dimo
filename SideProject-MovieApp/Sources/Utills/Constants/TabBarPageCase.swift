//
//  TabBarPageCase.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/30.
//

import Foundation

enum TabBarPageCase: String, CaseIterable {
    case home, check, profile, setting

    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .check
        case 2: self = .profile
        case 3: self = .setting
        default: return nil
        }
    }

    var pageOrderNumber: Int {
        switch self {
        case .home: return 0
        case .check: return 1
        case .profile: return 2
        case .setting: return 3
        }
    }

    var pageTitle: String {
        switch self {
        case .home:
            return "홈"
        case .check:
            return "검색"
        case .profile:
            return "백과사전"
        case .setting:
            return "내정보"
        }
    }

    func tabIconName() -> String {
        switch self {
        case .home:
            return "Home"
        case .check:
            return "Vote"
        case .profile:
            return "Profile"
        case .setting:
            return "Setting"
        }
    }
}
