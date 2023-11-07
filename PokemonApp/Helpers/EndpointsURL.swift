//
//  EndpointsURL.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 07.11.2023.
//

import Foundation

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
