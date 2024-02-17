//
//  Type.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

struct PokemonType: Codable {
    let id: String
    let name: String
    let damageRelations: PokemonTypeDamageRelations
    let moveDamageClass: NameURLStructure
    let pokemon: [PokemonTypePokemon]
    let moves: [NameURLStructure]
}

struct PokemonTypeDamageRelations {
    let noDamageTo: [NameURLStructure]
    let halfDamageTo: [NameURLStructure]
    let doubleDamageTo: [NameURLStructure]
    let noDamageFrom: [NameURLStructure]
    let halfDamangeTo: [NameURLStructure]
    let doubleDamageFrom: [NameURLStructure]
}

struct PokemonTypePokemon {
    let pokemon: NameURLStructure
}
