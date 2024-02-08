//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

struct Pokemon {
    let name: String
    let moves: [PokemonMove]
    let types: [PokemonNameURLStructure]
    let stats: [PokemonStat]
}

struct PokemonNameURLStructure {
    let name: String
    let url: String
}

struct PokemonMove {
    let move: PokemonNameURLStructure
}

struct PokemonStat {
    let baseStat: Int
    let effort: Int
    let statName: PokemonNameURLStructure
}
