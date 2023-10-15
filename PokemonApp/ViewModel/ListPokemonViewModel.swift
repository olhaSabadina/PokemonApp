//
//  ListPokemonViewModel.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 14.10.2023.
//

import UIKit

class ListPokemonViewModel {
    
    func listNumberOfItemsInSection() -> Int {
        return 20
    }
    
    func pokemonsName() -> String {
        return "URURU"
    }
    
    
    func pokemonsSkill() -> String {
        return "Gravity control"
    }
    
    func pokemonsPhoto() -> UIImage {
        return UIImage(named: "cat") ?? UIImage()
    }
}
