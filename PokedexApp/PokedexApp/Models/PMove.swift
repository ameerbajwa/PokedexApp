//
//  PMove.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

class PMove: PokemonSuperClass {
    let accuracy: Int
    let pp: Int
    let priority: Int
    let power: Int
    let damageClass: PokemonNameURLStructure
    let effectEntries: [PMoveEffectEntry]
    let meta: PMoveMeta
    let names: [PMoveName]
    let type: PokemonNameURLStructure
    let learnedByPokemon: [PokemonNameURLStructure]
    
    enum PMoveKeys: String, CodingKey {
        case accuracy, pp, priority, power, meta, names, type
        case damageClass = "damage_class"
        case effectEntries = "effect_entries"
        case learnedByPokemon = "learned_by_pokemon"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PMoveKeys.self)
        self.accuracy = try container.decode(Int.self, forKey: .accuracy)
        self.pp = try container.decode(Int.self, forKey: .pp)
        self.priority = try container.decode(Int.self, forKey: .priority)
        self.power = try container.decode(Int.self, forKey: .power)
        self.damageClass = try container.decode(PokemonNameURLStructure.self, forKey: .damageClass)
        self.effectEntries = try container.decode([PMoveEffectEntry].self, forKey: .effectEntries)
        self.meta = try container.decode(PMoveMeta.self, forKey: .meta)
        self.names = try container.decode([PMoveName].self, forKey: .names)
        self.type = try container.decode(PokemonNameURLStructure.self, forKey: .type)
        self.learnedByPokemon = try container.decode([PokemonNameURLStructure].self, forKey: .learnedByPokemon)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PMoveKeys.self)
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

struct PMoveEffectEntry: Codable {
    let effect: String
    let shortEffect: String
}

struct PMoveMeta: Codable {
    let ailment: PokemonNameURLStructure
    let category: PokemonNameURLStructure
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

struct PMoveName: Codable {
    let name: String
}
