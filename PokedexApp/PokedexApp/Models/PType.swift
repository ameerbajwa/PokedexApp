//
//  PType.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

class PType: PokemonSuperClass {
    let damageRelations: PTypeDamageRelations
    let moveDamageClass: PokemonNameURLStructure
    let pokemon: [PTypePokemon]
    let moves: [PokemonNameURLStructure]
    
    enum PTypeKey: String, CodingKey {
        case pokemon, moves
        case damageRelations = "damage_relations"
        case moveDamageClass = "move_damage_class"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PTypeKey.self)
        self.damageRelations = try container.decode(PTypeDamageRelations.self, forKey: .damageRelations)
        self.moveDamageClass = try container.decode(PokemonNameURLStructure.self, forKey: .moveDamageClass)
        self.pokemon = try container.decode([PTypePokemon].self, forKey: .pokemon)
        self.moves = try container.decode([PokemonNameURLStructure].self, forKey: .moves)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PTypeKey.self)
        try container.encode(self.damageRelations, forKey: .damageRelations)
        try container.encode(self.moveDamageClass, forKey: .moveDamageClass)
        try container.encode(self.pokemon, forKey: .pokemon)
        try container.encode(self.moves, forKey: .moves)
    }
}

struct PTypeDamageRelations: Codable {
    let noDamageTo: [PokemonNameURLStructure]
    let halfDamageTo: [PokemonNameURLStructure]
    let doubleDamageTo: [PokemonNameURLStructure]
    let noDamageFrom: [PokemonNameURLStructure]
    let halfDamangeTo: [PokemonNameURLStructure]
    let doubleDamageFrom: [PokemonNameURLStructure]
}

struct PTypePokemon: Codable {
    let pokemon: PokemonNameURLStructure
}
