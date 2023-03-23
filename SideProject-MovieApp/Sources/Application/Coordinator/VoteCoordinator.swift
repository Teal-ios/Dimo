import UIKit

final class IamTheCharacterDetailCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    func start() {
        let vc = IamTheCharacterDetailViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        print(childCoordinators)
    }
    
}

