//
//  PokemonAppUITests.swift
//  PokemonAppUITests
//
//  Created by Olga Sabadina on 05.11.2023.
//

import XCTest
@testable import PokemonApp

final class PokemonAppUITests: XCTestCase {

//    override func setUpWithError() throws {
//        continueAfterFailure = false
//    }
//
//    override func tearDownWithError() throws {
//    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.waitForExistence(timeout: 5))
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["BEEDRILL"]/*[[".cells.staticTexts[\"BEEDRILL\"]",".staticTexts[\"BEEDRILL\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.waitForExistence(timeout: 5))
        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["Stats"]/*[[".buttons[\"Stats\"].staticTexts[\"Stats\"]",".staticTexts[\"Stats\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        app/*@START_MENU_TOKEN@*/.staticTexts["Stats"]/*[[".buttons[\"Stats\"].staticTexts[\"Stats\"]",".staticTexts[\"Stats\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.staticTexts["Evolution"].exists)
        app.staticTexts["Evolution"].tap()
        XCTAssert(app.staticTexts["Moves"].exists)
        app.staticTexts["Moves"].tap()
        app.navigationBars["PokemonApp.DetailView"].buttons["arrow.backward"].tap()
    }

    
}
