//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

class Pokemon: PokemonSuperClass {
    var moves: [PokemonMove]
    var species: NameURLStructure
    var types: [PokemonType]
    var stats: [PokemonStat]
    
    enum PokemonKeys: CodingKey {
        case moves, species, types, stats
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        self.moves = try container.decode([PokemonMove].self, forKey: .moves)
        self.species = try container.decode(NameURLStructure.self, forKey: .species)
        self.types = try container.decode([PokemonType].self, forKey: .types)
        self.stats = try container.decode([PokemonStat].self, forKey: .stats)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PokemonKeys.self)
        try container.encode(self.moves, forKey: .moves)
        try container.encode(self.species, forKey: .species)
        try container.encode(self.types, forKey: .types)
        try container.encode(self.stats, forKey: .stats)
    }
}

struct PokemonMove: Codable {
    let move: NameURLStructure
}

struct PokemonType: Codable {
    let type: NameURLStructure
}

struct PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let statName: NameURLStructure
}
