//
//  ListPokemonViewModel.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 14.10.2023.
//

import UIKit
import Combine

class ListPokemonViewModel {
    
    private let networkManager = NetworkManager()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var pokemonsList: [PokemonModel] = []
    @Published var error: Error?
    
    init() {
      fetchPokemons()
    }
    
    func numberOfItemsInSection() -> Int {
        return pokemonsList.count
    }
    
    private func fetchPokemons() {
        loadPokemonsUrl()
            .flatMap(getAllPokemonsID)
            .flatMap(getAllPokemonts)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { pokemonArray in
                self.pokemonsList = pokemonArray.sorted { $0.name < $1.name }
            }
            .store(in: &cancellable)
    }
    
   private func loadPokemonsUrl() -> AnyPublisher<[String],Error> {
        networkManager.fetchPokemon(urlString: EndpointsURL.pokemonUrls.url, type: PokemonsListModel.self)
            .map { $0.pokemonsUrl }
            .eraseToAnyPublisher()
    }
    
    private func getAllPokemonsID(urlStrings: [String]) -> AnyPublisher<[PokemonID], Error> {
       
        let publishers: [AnyPublisher<PokemonID,Error>] = urlStrings.map(loadPokemonID)
       
        return Publishers.MergeMany(publishers)
            .collect(publishers.count)
            .eraseToAnyPublisher()
    }
    
    private func getAllPokemonts(pokemons: [PokemonID]) -> AnyPublisher<[PokemonModel], Error> {
        let publishers: [AnyPublisher<PokemonModel,Error>] =
        pokemons.map(loadPokemon)
        
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func loadPokemonID(urlString: String) -> AnyPublisher<PokemonID,Error> {
        networkManager.fetchPokemon(urlString: urlString, type: PokemonID.self)
    }
    
    private func loadPokemon(pokemonId: PokemonID) -> AnyPublisher<PokemonModel, Error> {
        networkManager.fetchPokemon(urlString: EndpointsURL.pokemonFromID(pokemonId.id).url, type: PokemonModel.self)
    }
}
