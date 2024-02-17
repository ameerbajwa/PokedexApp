//
//  PokemonSpecies.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

class PokemonSpecies: PokemonClass {
    let evolutionChain: PokemonSpeciesEvolutionChainUrl
    let evolvesFromSpecies: NameURLStructure
    let habitat: NameURLStructure
    
    enum PokemonSpeciesKeys: CodingKey {
        case evolutionChain, evolvesFromSpecies, habitat
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonSpeciesKeys.self)
        self.evolutionChain = try container.decode(PokemonSpeciesEvolutionChainUrl.self, forKey: .evolutionChain)
        self.evolvesFromSpecies = try container.decode(NameURLStructure.self, forKey: .evolvesFromSpecies)
        self.habitat = try container.decode(NameURLStructure.self, forKey: .habitat)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PokemonSpeciesKeys.self)
        try container.encode(self.evolutionChain, forKey: .evolutionChain)
        try container.encode(self.evolvesFromSpecies, forKey: .evolvesFromSpecies)
        try container.encode(self.habitat, forKey: .habitat)
    }
}

struct PokemonSpeciesEvolutionChainUrl: Codable {
    let url: String
}
