//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

class Pokemon: PokemonClass {
    var moves: [PokemonLearnedMove]
    var species: NameURLStructure
    var types: [NameURLStructure]
    var stats: [PokemonStat]
    
    enum PokemonKeys: CodingKey {
        case moves, species, types, stats
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        self.moves = try container.decode([PokemonLearnedMove].self, forKey: .moves)
        self.species = try container.decode(NameURLStructure.self, forKey: .species)
        self.types = try container.decode([NameURLStructure].self, forKey: .types)
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

struct PokemonLearnedMove: Codable {
    let move: NameURLStructure
}

struct PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let statName: NameURLStructure
}
