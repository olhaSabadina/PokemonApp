//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 15.10.2023.
//

import Foundation
import Combine

 enum EndpointsURL {
     static let pokemonsList = "ability/?limit=20"
     static let about = "ability/{id or name}/"
     static let stats = "stat/{id or name}/"
     static let evolution = "evolution-chain/{id}/"
     static let moves = "move/{id or name}/"
}


struct NetworkManager {
    
    private let baseUrl = "https://pokeapi.co/api/v2/"
    
    func fetchPokemon<T:Codable>(url: String? = nil, type: T.Type) -> AnyPublisher<T,Error> {
        
        var urlString = baseUrl + EndpointsURL.pokemonsList
        if let url {
            urlString = url
        }
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
