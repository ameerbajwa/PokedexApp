//
//  PSpecies.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

class PSpecies: PokemonSuperClass {
    let evolutionChain: PSpeciesEvolutionChainUrl
    let evolvesFromSpecies: PokemonNameURLStructure
    let habitat: PokemonNameURLStructure
    
    enum PSpeciesKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
        case evolvesFromSpecies = "evolves_from_species"
        case habitat
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PSpeciesKeys.self)
        self.evolutionChain = try container.decode(PSpeciesEvolutionChainUrl.self, forKey: .evolutionChain)
        self.evolvesFromSpecies = try container.decode(PokemonNameURLStructure.self, forKey: .evolvesFromSpecies)
        self.habitat = try container.decode(PokemonNameURLStructure.self, forKey: .habitat)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PSpeciesKeys.self)
        try container.encode(self.evolutionChain, forKey: .evolutionChain)
        try container.encode(self.evolvesFromSpecies, forKey: .evolvesFromSpecies)
        try container.encode(self.habitat, forKey: .habitat)
    }
}

struct PSpeciesEvolutionChainUrl: Codable {
    let url: String
}
