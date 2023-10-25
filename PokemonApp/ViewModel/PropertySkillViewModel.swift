//
//  PropertySkillViewModel.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit
import Combine

class PropertySkillViewModel {
    
    enum SkillProperties {
        case height
        case weight
        case power
        case attack
        case damage
        case description
        
        var title: String {
            switch self {
            case .height:
                return "Height"
            case .weight:
                return "Weight"
            case .power:
                return "Power"
            case .attack:
                return "Attack"
            case .damage:
                return "Damage"
            case .description:
                return ""
            }
        }
    }
    
    let pokemon: Pokemon
   
    @Published var cellModels: [SkillsCellModel] = []
    
    init (pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    func createCellModels(sectionTag: Int) -> [SkillsCellModel] {
        switch sectionTag {
        case 0:
           break
        case 1:
            return [SkillsCellModel(valueProperty: "tag 1")]
        case 2:
            return [SkillsCellModel(valueProperty: "tag 2")]
        case 3:
            return [SkillsCellModel(valueProperty: "tag 3")]
        
        default: break
        }
        return []
    }
    
    func createCellModelForAboutSkills() {
        
    }
    
    func numberOfRowsInSection() -> Int {
        return cellModels.count
    }
}
