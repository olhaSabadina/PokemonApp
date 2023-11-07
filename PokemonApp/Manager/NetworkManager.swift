//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 15.10.2023.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func fetchPokemon<T:Codable>(urlString: String, type: T.Type) -> AnyPublisher<T,Error>
}

struct NetworkManager: NetworkProtocol {
    
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
