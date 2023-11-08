//
//  PokemonsList.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 15.10.2023.
//

import Foundation

// MARK: - ListName
struct PokemonsListModel: Codable {
    let results: [Result]
    
    var pokemonsUrl: [String] {
        var urlArray: [String] = []
        results.forEach { urlArray.append($0.url) }
        return urlArray
    }
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}

// MARK: - ID Pokemon
struct PokemonID: Codable {
    let id: Int
}
