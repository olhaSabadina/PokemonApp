//
//  CoordinatorMain.swift
//  trainCoordinator
//
//  Created by Olga Sabadina on 03.11.2023.
//

import UIKit

enum NextCoordinator {
    case mainScreen
    case pokemonDescription(pokemon: PokemonModel)
}

class AppCoordinator: NSObject, CoordinatorProtocol, UINavigationControllerDelegate {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        openListPokemon()
    }
    
    func childDidFinish(_ coordinator : CoordinatorProtocol?, moveToNext: NextCoordinator? = nil) {
       
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                navigationController.viewControllers.remove(at: index)
                break
            }
        }
        guard let nextCoordinator = moveToNext else { return }
        moveTo(coordinator: nextCoordinator)
    }
    
    private func moveTo(coordinator: NextCoordinator) {
        switch coordinator {
        case .mainScreen:
            openListPokemon()
        case .pokemonDescription(let pokemon):
           openPokemonDescription(pokemon: pokemon)
        }
    }
    
    private func openListPokemon() {
        let listCoordinator = ListCoordinator(navController: navigationController)
        childCoordinators.append(listCoordinator)
        listCoordinator.parentCoordinator = self
        listCoordinator.start()
    }
    
    private func openPokemonDescription(pokemon: PokemonModel) {
       let detailCoordinator = DetailSkillsCoordinator(navController: navigationController, pokemon: pokemon)
        childCoordinators.append(detailCoordinator)
        detailCoordinator.parentCoordinator = self
        detailCoordinator.start()
    }
    
}
