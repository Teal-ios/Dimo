//
//  InitialViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/03/23.
//

import Foundation

final class OnBoardingViewModel {
    
    private weak var coordinator: AuthCoordinator?

    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }
}
