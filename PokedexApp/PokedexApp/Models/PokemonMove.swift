//
//  Move.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

struct PokemonMove: Codable {
    let id: Int
    let name: String
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
}

struct PokemonMoveEffectEntry {
    let effect: String
    let shortEffect: String
}

struct PokemonMoveMeta {
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

struct PokemonMoveName {
    let name: String
}
