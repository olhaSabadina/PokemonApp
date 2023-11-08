//
//  PokemonAppTests.swift
//  PokemonAppTests
//
//  Created by Olga Sabadina on 05.11.2023.
//

import XCTest
import Combine
@testable import PokemonApp

final class PokemonAppTests: XCTestCase {
    
    var listViewModel: ListPokemonViewModel?
    var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        let networkManager = NetworkManager()
        listViewModel = ListPokemonViewModel(networkManager: networkManager)
    }
    
    override func tearDown() {
        super.tearDown()
        listViewModel = nil
        cancellable.removeAll()
    }
    
    func testFetchPokemonList() {
        let expectation = XCTestExpectation(description: "Fetch ListPokemon")
        listViewModel?.$pokemonsList
            .drop { $0.isEmpty }
            .sink { value in
                XCTAssertFalse(value.count == 0)
                XCTAssert(value.count == 20)
                expectation.fulfill()
            }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
