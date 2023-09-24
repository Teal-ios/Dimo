//
//  CharacterMoreCoordinator.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/09/24.
//

import UIKit

final class CharacterMoreCoordinator: Coordinator, CoordinatorDelegate {
    func start() {
        showCharacterMoreViewController(characterData: characterData)
    }
    
    
    
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
    
    weak var delegate: CoordinatorDelegate?
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .tab
    var characterData: [SameMbtiCharacter]
    
    init(_ navigationController: UINavigationController, characterData: [SameMbtiCharacter]) {
        self.navigationController = navigationController
        self.characterData = characterData
    }
    
    func showCharacterMoreViewController(characterData: [SameMbtiCharacter]) {
        let viewModel = CharacterMoreViewModel(coordinator: self, characters: characterData)
        let vc = CharacterMoreViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showTabmanCharacterCoordinator(character: Characters) {
        let tabmanCoordinator = TabmanCoordinator(navigationController, character: character, connectconnetTabmanCoordinatorViewController: .tabman, review: nil)
        tabmanCoordinator.delegate = self
        self.childCoordinators.append(tabmanCoordinator)
        tabmanCoordinator.start()
    }
}
