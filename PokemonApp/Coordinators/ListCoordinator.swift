//
//  MainScreenCoordinator.swift
//  trainCoordinator
//
//  Created by Olga Sabadina on 05.11.2023.
//

import UIKit

class ListCoordinator: CoordinatorProtocol {
   
    weak var parentCoordinator: AppCoordinator?
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let viewModel = ListPokemonViewModel()
        let vc = ListViewController()
        vc.listPokemonViewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func stop(andMoveTo: NextCoordinator? = nil) {
        parentCoordinator?.childDidFinish(self, moveToNext: andMoveTo)
    }
    
}
