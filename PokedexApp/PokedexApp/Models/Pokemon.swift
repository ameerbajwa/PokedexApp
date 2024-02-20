//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

class Pokemon: PokemonSuperClass {
    let moves: [PokemonMove]
    let species: PokemonNameURLStructure
    let types: [PokemonType]
    let stats: [PokemonStat]
    
    private enum PokemonKeys: String, CodingKey {
        case moves, species, types, stats
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        self.moves = try container.decode([PokemonMove].self, forKey: .moves)
        self.species = try container.decode(PokemonNameURLStructure.self, forKey: .species)
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

class PokemonMove: Codable {
    let move: PokemonNameURLStructure
    
    private enum PokemonMoveKeys: String, CodingKey {
        case move
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonMoveKeys.self)
        self.move = try container.decode(PokemonNameURLStructure.self, forKey: .move)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PokemonMoveKeys.self)
        try container.encode(self.move, forKey: .move)
    }
}

class PokemonType: Codable {
    let type: PokemonNameURLStructure
    
    private enum PokemonTypeKeys: String, CodingKey {
        case type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonTypeKeys.self)
        self.type = try container.decode(PokemonNameURLStructure.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PokemonTypeKeys.self)
        try container.encode(self.type, forKey: .type)
    }
}

class PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: PokemonNameURLStructure
    
    private enum PokemonStatKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonStatKeys.self)
        self.baseStat = try container.decode(Int.self, forKey: .baseStat)
        self.effort = try container.decode(Int.self, forKey: .effort)
        self.stat = try container.decode(PokemonNameURLStructure.self, forKey: .stat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PokemonStatKeys.self)
        try container.encode(self.baseStat, forKey: .baseStat)
        try container.encode(self.effort, forKey: .effort)
        try container.encode(self.stat, forKey: .stat)
    }
}
