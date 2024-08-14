//
//  PVersion.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 8/12/24.
//

import Foundation

class PVersion: PokemonSuperClass {
    let generation: PokemonNameURLStructure
    let versions: [PokemonNameURLStructure]
    
    private enum PVersionKeys: String, CodingKey {
        case generation, versions
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PVersionKeys.self)
        self.generation = try container.decode(PokemonNameURLStructure.self, forKey: .generation)
        self.versions = try container.decode([PokemonNameURLStructure].self, forKey: .versions)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PVersionKeys.self)
        try container.encode(self.generation, forKey: .generation)
        try container.encode(self.versions, forKey: .versions)
    }
}
