//
//  PGeneration.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/11/24.
//

import Foundation

class PGeneration: PokemonSuperClass {
    let mainRegion: PokemonNameURLStructure
    let pokemonSpecies: [PokemonNameURLStructure]
    let versionGroups: [PokemonNameURLStructure]
    
    private enum PGenerationKeys: String, CodingKey {
        case mainRegion = "main_region"
        case pokemonSpecies = "pokemon_species"
        case versionGroups = "version_groups"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PGenerationKeys.self)
        self.mainRegion = try container.decode(PokemonNameURLStructure.self, forKey: .mainRegion)
        self.pokemonSpecies = try container.decode([PokemonNameURLStructure].self, forKey: .pokemonSpecies)
        self.versionGroups = try container.decode([PokemonNameURLStructure].self, forKey: .versionGroups)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PGenerationKeys.self)
        try container.encode(self.mainRegion, forKey: .mainRegion)
        try container.encode(self.pokemonSpecies, forKey: .pokemonSpecies)
        try container.encode(self.versionGroups, forKey: .versionGroups)
    }
}
