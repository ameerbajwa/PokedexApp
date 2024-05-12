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
    let sprites: PokemonSprites
    let abilities: [PokemonAbility]
    
    private enum PokemonKeys: String, CodingKey {
        case moves, species, types, stats, sprites, abilities
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        self.moves = try container.decode([PokemonMove].self, forKey: .moves)
        self.species = try container.decode(PokemonNameURLStructure.self, forKey: .species)
        self.types = try container.decode([PokemonType].self, forKey: .types)
        self.stats = try container.decode([PokemonStat].self, forKey: .stats)
        self.sprites = try container.decode(PokemonSprites.self, forKey: .sprites)
        self.abilities = try container.decode([PokemonAbility].self, forKey: .abilities)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PokemonKeys.self)
        try container.encode(self.moves, forKey: .moves)
        try container.encode(self.species, forKey: .species)
        try container.encode(self.types, forKey: .types)
        try container.encode(self.stats, forKey: .stats)
        try container.encode(self.sprites, forKey: .sprites)
        try container.encode(self.abilities, forKey: .abilities)
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

class PokemonSprites: Codable {
    let frontPokemonImageUrl: String
    let backPokemonImageUrl: String
    
    private enum PokemonSpritesKeys: String, CodingKey {
        case frontPokemonImageUrl = "front_default"
        case backPokemonImageUrl = "back_default"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonSpritesKeys.self)
        self.frontPokemonImageUrl = try container.decode(String.self, forKey: .frontPokemonImageUrl)
        self.backPokemonImageUrl = try container.decode(String.self, forKey: .backPokemonImageUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PokemonSpritesKeys.self)
        try container.encode(self.frontPokemonImageUrl, forKey: .frontPokemonImageUrl)
        try container.encode(self.backPokemonImageUrl, forKey: .backPokemonImageUrl)
    }
}

struct PokemonAbility: Codable {
    let ability: PokemonNameURLStructure
}
