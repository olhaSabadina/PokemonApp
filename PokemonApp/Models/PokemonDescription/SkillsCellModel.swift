//
//  SkillsCellModel.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 14.10.2023.
//

import Foundation

struct SkillsCellModel {
    let titleProperty: String?
    let valueProperty: String
    let attackPowerCount: Int
    
    init(titleProperty: String? = nil, valueProperty: String, attackPowerCount: Int = 0) {
        self.titleProperty = titleProperty
        self.valueProperty = valueProperty
        self.attackPowerCount = attackPowerCount
    }
}
