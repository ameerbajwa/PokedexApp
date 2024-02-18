//
//  PType.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

class PType: PokemonSuperClass {
    let damageRelations: PTypeDamageRelations
    let moveDamageClass: NameURLStructure
    let pokemon: [PTypePokemon]
    let moves: [NameURLStructure]
    
    enum PTypeKey: CodingKey {
        case damageRelations, moveDamageClass, pokemon, moves
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PTypeKey.self)
        self.damageRelations = try container.decode(PTypeDamageRelations.self, forKey: .damageRelations)
        self.moveDamageClass = try container.decode(NameURLStructure.self, forKey: .moveDamageClass)
        self.pokemon = try container.decode([PTypePokemon].self, forKey: .pokemon)
        self.moves = try container.decode([NameURLStructure].self, forKey: .moves)
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
    let noDamageTo: [NameURLStructure]
    let halfDamageTo: [NameURLStructure]
    let doubleDamageTo: [NameURLStructure]
    let noDamageFrom: [NameURLStructure]
    let halfDamangeTo: [NameURLStructure]
    let doubleDamageFrom: [NameURLStructure]
}

struct PTypePokemon: Codable {
    let pokemon: NameURLStructure
}
