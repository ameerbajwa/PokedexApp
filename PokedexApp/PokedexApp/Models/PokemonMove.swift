//
//  Move.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

class PokemonMove: PokemonClass {
    let accuracy: Int
    let pp: Int
    let priority: Int
    let power: Int
    let damageClass: NameURLStructure
    let effectEntries: [PokemonMoveEffectEntry]
    let meta: PokemonMoveMeta
    let names: [PokemonMoveName]
    let type: NameURLStructure
    let learnedByPokemon: [NameURLStructure]
    
    enum PokemonMoveKeys: CodingKey {
        case accuracy, pp, priority, power, damageClass, effectEntries, meta, names, type, learnedByPokemon
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonMoveKeys.self)
        self.accuracy = try container.decode(Int.self, forKey: .accuracy)
        self.pp = try container.decode(Int.self, forKey: .pp)
        self.priority = try container.decode(Int.self, forKey: .priority)
        self.power = try container.decode(Int.self, forKey: .power)
        self.damageClass = try container.decode(NameURLStructure.self, forKey: .damageClass)
        self.effectEntries = try container.decode([PokemonMoveEffectEntry].self, forKey: .effectEntries)
        self.meta = try container.decode(PokemonMoveMeta.self, forKey: .meta)
        self.names = try container.decode([PokemonMoveName].self, forKey: .names)
        self.type = try container.decode(NameURLStructure.self, forKey: .type)
        self.learnedByPokemon = try container.decode([NameURLStructure].self, forKey: .learnedByPokemon)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PokemonMoveKeys.self)
        try container.encode(self.accuracy, forKey: .accuracy)
        try container.encode(self.pp, forKey: .pp)
        try container.encode(self.priority, forKey: .priority)
        try container.encode(self.power, forKey: .power)
        try container.encode(self.damageClass, forKey: .damageClass)
        try container.encode(self.effectEntries, forKey: .effectEntries)
        try container.encode(self.meta, forKey: .meta)
        try container.encode(self.names, forKey: .names)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.learnedByPokemon, forKey: .learnedByPokemon)
    }
}

struct PokemonMoveEffectEntry: Codable {
    let effect: String
    let shortEffect: String
}

struct PokemonMoveMeta: Codable {
    let ailment: NameURLStructure
    let category: NameURLStructure
    let minHits: Int?
    let maxHits: Int?
    let minTurns: Int?
    let maxTurns: Int?
    let drain: Int
    let healing: Int
    let critRate: Int
    let ailmentChance: Int
    let flinchChance: Int
    let statChance: Int
}

struct PokemonMoveName: Codable {
    let name: String
}
