//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 15.10.2023.
//

import Foundation
import Combine

 enum EndpointsURL {
     static let baseUrl = "https://pokeapi.co/api/v2/"
     static let pokemonsList = "ability/?limit=20"
    
     case pokemonUrls
     case pokemonFromID (Int)
     
     var url: String {
         switch self {
         case .pokemonUrls:
             return EndpointsURL.baseUrl + EndpointsURL.pokemonsList
         case .pokemonFromID(let id):
             return EndpointsURL.baseUrl + "pokemon/\(id)/"
         }
     }
}

struct NetworkManager {
    
    func fetchPokemon<T:Codable>(urlString: String, type: T.Type) -> AnyPublisher<T,Error> {

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
