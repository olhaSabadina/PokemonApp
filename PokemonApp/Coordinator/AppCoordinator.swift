//
//  CoordinatorMain.swift
//  trainCoordinator
//
//  Created by Olga Sabadina on 03.11.2023.
//

import UIKit

enum NextCoordinator {
    case mainScreen
    case pokemonDescription
}

class AppCoordinator: NSObject, CoordinatorProtocol, UINavigationControllerDelegate {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainCoordinator = MainScreenCoordinator(navController: navigationController)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.parentCoordinator = self
        mainCoordinator.start()
    }
    
    func childDidFinish(_ coordinator : CoordinatorProtocol?, moveToNext: NextCoordinator? = nil) {
       
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                navigationController.viewControllers.remove(at: index)
                break
            }
        }
        guard let coordinator = moveToNext else { return }
        moveTo(coordinator: coordinator)
    }
    
    private func moveTo(coordinator: NextCoordinator) {
        switch coordinator {
        case .mainScreen:
            start()
        case .pokemonDescription:
           // goToSecondVC()
            break
        }
    }
    
}
