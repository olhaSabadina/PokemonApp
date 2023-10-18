//
//  ListPokemonViewModel.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 14.10.2023.
//

import UIKit
import Combine

class ListPokemonViewModel {
    
    let networkManager = NetworkManager()
    var cancellable = Set<AnyCancellable>()
    @Published var pokemonsList: [String] = []
    
    @Published var isReloadCollection = false
    
    var idDescription: AnyPublisher<PokemonID,Never> {
        return $pokemonsList
            .map { item in
                item.forEach { url in
                    self.networkManager.fetchPokemon(url: url, type: PokemonID.self)
                        
                   
                }
            }
           
            .sink { item in
                <#code#>
            }
            .store(in: &cancellable)
           
            
    }
    
    func listNumberOfItemsInSection() -> Int {
        return pokemonsList.count
    }
    
    func fechPokemonsList() {
        networkManager.fetchPokemon(type: PokemonsListModel.self)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isReloadCollection = true
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { listNames in
                self.pokemonsList = listNames.urlPokemonsAbility
                print(self.pokemonsList[0])
            }.store(in: &cancellable)
    }
    
    
}



//class ListPokemonViewModel1 {
//
//    func listNumberOfItemsInSection() -> Int {
//        return 20
//    }
//
//    func pokemonsName() -> String {
//        return "URURU"
//    }
//
//
//    func pokemonsSkill() -> String {
//        return "Gravity control"
//    }
//
//    func pokemonsPhoto() -> UIImage {
//        return UIImage(named: "cat") ?? UIImage()
//    }
//}
