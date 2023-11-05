//
//  PokemonDescriptionTests.swift
//  PokemonAppTests
//
//  Created by Olga Sabadina on 05.11.2023.
//

import XCTest
import Combine
@testable import PokemonApp

final class PokemonDescriptionTests: XCTestCase {
    
        var listViewModel = ListPokemonViewModel()
        var cancellable = Set<AnyCancellable>()
        
        @Published var pokemon: PokemonModel?
        
        override func setUp() {
            super.setUp()
            listViewModel = ListPokemonViewModel()
            listViewModel.$pokemonsList
                .drop { $0.isEmpty }
                .sink(receiveValue: { arrayPokemon in
                self.pokemon = arrayPokemon[0]
            })
            .store(in: &cancellable)
        }

        override func tearDown() {
            super.tearDown()
            cancellable.removeAll()
        }
       
        func testPokemonDescription() {
           let expectation = XCTestExpectation(description: "Fetch PokemonDescription")
            $pokemon
                .compactMap { $0 }
                .sink { pokemon in
                    let descriptionPokemon = PropertySkillViewModel(pokemon: pokemon)
                    descriptionPokemon.$cellModels
                        .drop { $0.isEmpty }
                        .sink { pokemonSkill in
                            XCTAssert(!pokemonSkill.isEmpty)
                            XCTAssert( pokemonSkill.count == 6 )
                        }.store(in: &self.cancellable)
                    expectation.fulfill()
                }
                .store(in: &cancellable)
            wait(for: [expectation], timeout: 5.0)
        }
}
