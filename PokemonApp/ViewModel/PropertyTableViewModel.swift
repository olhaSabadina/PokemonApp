//
//  PropertyTableViewModel.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit
import Combine

class PropertyTableViewModel {
    
   @Published var cellModels: [SkillsCellModel] = []
    
    init () {
        fetchProperties()
    }
    
    func fetchProperties() {
        //получаем данные распарсиваем и превращ в массив модэлек
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.cellModels = [
                SkillsCellModel(titleProperty: "Height",
                          valueProperty: "1120mm",
                          attackPowerCount: nil),
                SkillsCellModel(titleProperty: "Weight",
                          valueProperty: "7 kg",
                          attackPowerCount: nil),
                SkillsCellModel(titleProperty: "Power",
                          valueProperty: "Explosive Farting",
                          attackPowerCount: nil),
                SkillsCellModel(titleProperty: "Attack",
                          valueProperty: "Fire Spins",
                          attackPowerCount: 4),
                SkillsCellModel(titleProperty: "Damage",
                          valueProperty: "100",
                          attackPowerCount: nil),
            ]
        }
    }
    
    func detailNumberOfRowsInSection() -> Int {
        return cellModels.isEmpty ? 0 : cellModels.count + 1
    }
}
