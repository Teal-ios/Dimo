//
//  LoginSplashViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

import Foundation

final class LoginSplashViewModel {
    private weak var coordinator: LoginCoordinator?

    init(coordinator: LoginCoordinator?) {
        self.coordinator = coordinator
    }
    
    func presentLoginStartViewController() {
        self.coordinator?.showLoginStartViewController()
    }
}
