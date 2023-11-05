//
//  String+Extension.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 25.10.2023.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
