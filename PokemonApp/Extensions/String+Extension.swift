//
//  String+Extension.swift
//  PokemonApp
//
//  Created by Yura Sabadin on 25.10.2023.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
