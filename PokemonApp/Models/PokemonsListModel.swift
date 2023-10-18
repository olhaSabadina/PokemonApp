//
//  PokemonsList.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 15.10.2023.
//

import Foundation

// MARK: - ListName
struct PokemonsListModel: Codable {
    let count: Int
    let next: String
    let results: [Result]
    
    var urlPokemonsAbility: [String] {
        var urlArray: [String] = []
        results.forEach { urlArray.append($0.url) }
        return urlArray
    }
}

// MARK: - ResultListName
struct Result: Codable {
    let name: String
    let url: String
}

