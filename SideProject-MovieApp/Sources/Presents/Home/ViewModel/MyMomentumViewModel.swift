//
//  MyMomentumViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/05/02.
//

import Foundation

final class MyMomentumViewModel {
    
    private weak var coordinator: MyMomentumCoordinator?

    init(coordinator: MyMomentumCoordinator?) {
        self.coordinator = coordinator
    }
}
