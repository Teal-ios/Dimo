//
//  HomeViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/04.
//

import Foundation

final class HomeViewModel {
    
    private weak var coordinator: HomeCoordinator?

    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
}
