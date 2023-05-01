//
//  VoteViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/01.
//

import Foundation

final class VoteViewModel {
    
    private weak var coordinator: VoteCoordinator?

    init(coordinator: VoteCoordinator?) {
        self.coordinator = coordinator
    }
}
