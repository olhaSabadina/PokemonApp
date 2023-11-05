//
//  MainScreenCoordinator.swift
//  trainCoordinator
//
//  Created by Olga Sabadina on 05.11.2023.
//

import UIKit

class MainScreenCoordinator: CoordinatorProtocol {
   
    weak var parentCoordinator: AppCoordinator?
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    
    func start() {
        let vc = ListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func stop(andMoveTo: NextCoordinator? = nil) {
        parentCoordinator?.childDidFinish(self, moveToNext: andMoveTo)
    }
    
    func openPokemomDescription(_ pokemon: PokemonModel) {
        let propertyViewModel = PropertySkillViewModel(pokemon: pokemon)
        
        let descriptionVC = DetailViewController(viewModel: propertyViewModel)
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        navigationController.view.layer.add(transition, forKey: kCATransition)
        
        navigationController.pushViewController(descriptionVC, animated: false)
    }
    
}
