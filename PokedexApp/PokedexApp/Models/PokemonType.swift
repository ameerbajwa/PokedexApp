//
//  Type.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

class PokemonType: PokemonClass {
    let damageRelations: PokemonTypeDamageRelations
    let moveDamageClass: NameURLStructure
    let pokemon: [PokemonTypePokemon]
    let moves: [NameURLStructure]
    
    enum PokemonTypeKey: CodingKey {
        case damageRelations, moveDamageClass, pokemon, moves
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonTypeKey.self)
        self.damageRelations = try container.decode(PokemonTypeDamageRelations.self, forKey: .damageRelations)
        self.moveDamageClass = try container.decode(NameURLStructure.self, forKey: .moveDamageClass)
        self.pokemon = try container.decode([PokemonTypePokemon].self, forKey: .pokemon)
        self.moves = try container.decode([NameURLStructure].self, forKey: .moves)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PokemonTypeKey.self)
        try container.encode(self.damageRelations, forKey: .damageRelations)
        try container.encode(self.moveDamageClass, forKey: .moveDamageClass)
        try container.encode(self.pokemon, forKey: .pokemon)
        try container.encode(self.moves, forKey: .moves)
    }
}

struct PokemonTypeDamageRelations: Codable {
    let noDamageTo: [NameURLStructure]
    let halfDamageTo: [NameURLStructure]
    let doubleDamageTo: [NameURLStructure]
    let noDamageFrom: [NameURLStructure]
    let halfDamangeTo: [NameURLStructure]
    let doubleDamageFrom: [NameURLStructure]
}

struct PokemonTypePokemon: Codable {
    let pokemon: NameURLStructure
}
