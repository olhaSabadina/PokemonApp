//
//  PokemonAbility..swift
//  PokemonApp
//
//  Created by Yura Sabadin on 25.10.2023.
//

import Foundation

// MARK: - PokemonAbility
struct PokemonAbility: Codable {
    
    let effectEntries: [EffectEntry]
    let flavorTextEntries: [FlavorTextEntry]
    let generation: Generation
    let id: Int
    let isMainSeries: Bool
    let name: String
    let names: [Name]
   

    enum CodingKeys: String, CodingKey {
       
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case generation, id
        case isMainSeries = "is_main_series"
        case name, names
    }
}

// MARK: - EffectEntry
struct EffectEntry: Codable {
    let effect: String
    let language: Generation
    let shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

// MARK: - Generation
struct Generation: Codable {
    let name: String
    let url: String
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language, versionGroup: Generation

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
}

// MARK: - Name
struct Name: Codable {
    let language: Generation
    let name: String
}

// MARK: - Pokemon
struct Pokemon: Codable {
    let isHidden: Bool
    let pokemon: Generation
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case pokemon, slot
    }
}
