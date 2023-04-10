//
//  LoginStartViewModel.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/04/10.
//

import Foundation

final class LoginStartViewModel {
    private weak var coordinator: AuthCoordinator?

    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }
    
    func pushSignupTermsViewController() {
        self.coordinator?.showSignupTermsViewController()
    }
}
