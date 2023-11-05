//
//  DetailScreenCoordinator.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 05.11.2023.
//

import UIKit

class DetailSkillsCoordinator: CoordinatorProtocol {
   
    weak var parentCoordinator: AppCoordinator?
    
    var pokemon: PokemonModel
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navController: UINavigationController, pokemon: PokemonModel) {
        self.navigationController = navController
        self.pokemon = pokemon
    }
    
    func start() {
        let propertyViewModel = PropertySkillViewModel(pokemon: pokemon)
        
        let descriptionVC = DetailViewController(viewModel: propertyViewModel)
        descriptionVC.coordinator = self
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        navigationController.view.layer.add(transition, forKey: kCATransition)
        
        navigationController.pushViewController(descriptionVC, animated: false)
    }
    
    func stop(andMoveTo: NextCoordinator? = nil) {
        parentCoordinator?.childDidFinish(self, moveToNext: andMoveTo)
    }
}
