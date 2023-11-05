//
//  PropertySkillViewModel.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit
import Combine

enum SkillProperties: CaseIterable {
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

class PropertySkillViewModel {
    
    @Published var cellModels: [SkillsCellModel] = []
    @Published var error: Error?
    
    let pokemon: PokemonModel
    var selectedTag: Int = 0 {
        didSet{
          cellModels = createCellModels(sectionTag: selectedTag)
        }
    }
    
    private var pokemonAbility: PokemonAbility?
    private let networkManager = NetworkManager()
    private var subscribers = Set<AnyCancellable>()
   
    init (pokemon: PokemonModel) {
        self.pokemon = pokemon
        loadPokemonAbility()
    }
    
    func createCellModels(sectionTag: Int) -> [SkillsCellModel] {
        switch sectionTag {
        case 0:
           return createCellModelForAboutSkills()
        case 1:
            return createCellModelForStatsSkills()
        case 2:
            return [SkillsCellModel(titleProperty: "Evolutoin:", valueProperty: pokemonAbility?.effectEntries[0].shortEffect.capitalizeFirstLetter() ?? "")]
        case 3:
            return createCellModelForMovesSkills()
        
        default: break
        }
        return []
    }
    
    func createCellModelForMovesSkills() -> [SkillsCellModel] {
        var models: [SkillsCellModel] = []
        pokemon.moves.forEach { item in
            let model = SkillsCellModel(titleProperty: item.move.name.capitalizeFirstLetter(), valueProperty: "\(item.versionGroupDetails[0].moveLearnMethod.name) - method")
            models.append(model)
        }
        return models
    }
    
    func createCellModelForStatsSkills() -> [SkillsCellModel] {
        var models: [SkillsCellModel] = []
        pokemon.stats.forEach { item in
            let model = SkillsCellModel(titleProperty: item.stat.name.capitalizeFirstLetter(), valueProperty: "\(item.baseStat)  point")
            models.append(model)
        }
        return models
    }
    
    func createCellModelForAboutSkills() -> [SkillsCellModel] {
        var models: [SkillsCellModel] = []
        
        SkillProperties.allCases.forEach { skill in
            switch skill {
            case .height:
                let model = SkillsCellModel(titleProperty: SkillProperties.height.title,
                                            valueProperty: pokemon.heightConvert)
                models.append(model)
            case .weight:
                let model = SkillsCellModel(titleProperty: SkillProperties.weight.title,
                                            valueProperty: pokemon.weightConvert)
                models.append(model)
            case .power:
                let model = SkillsCellModel(titleProperty: SkillProperties.power.title,
                                            valueProperty: pokemon.abilities[0].ability.name.capitalizeFirstLetter())
                models.append(model)
            case .attack:
                let attackPower = Int.random(in: 1...5)
                let model = SkillsCellModel(titleProperty: SkillProperties.attack.title,
                                            valueProperty: pokemon.abilities.count > 1 ?
                                            pokemon.abilities[1].ability.name.capitalizeFirstLetter() : "Attack power",
                                            attackPowerCount: attackPower)
                models.append(model)
            case .damage:
                let model = SkillsCellModel(titleProperty: SkillProperties.damage.title,
                                            valueProperty: pokemon.damageConvert)
                models.append(model)
            case .description:
                let model = SkillsCellModel(valueProperty: pokemonAbility?.effectEntries[0].effect.capitalizeFirstLetter() ?? "none")
                models.append(model)
            }
        }
        return models
    }
    
    func loadPokemonAbility() {
        networkManager.fetchPokemon(urlString: pokemon.abilities[0].ability.url, type: PokemonAbility.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { pokemonAbl in
                self.pokemonAbility = pokemonAbl
                self.cellModels = self.createCellModels(sectionTag: self.selectedTag)
            }
            .store(in: &subscribers)
    }
    
    func numberOfRowsInSection() -> Int {
        return cellModels.count
    }
}
