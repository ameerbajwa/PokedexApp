//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

struct Pokemon {
    let id: Int
    let name: String
    let moves: [PokemonLearnedMove]
    let types: [NameURLStructure]
    let stats: [PokemonStat]
}

struct NameURLStructure {
    let name: String
    let url: String
}

struct PokemonLearnedMove {
    let move: NameURLStructure
}

struct PokemonStat {
    let baseStat: Int
    let effort: Int
    let statName: NameURLStructure
}
