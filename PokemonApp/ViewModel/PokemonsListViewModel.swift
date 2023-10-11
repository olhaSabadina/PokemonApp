//
//  PokemonsListViewModel.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit

class PokemonsListViewModel {
    
    func numberOfItemsInSection() -> Int {
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
