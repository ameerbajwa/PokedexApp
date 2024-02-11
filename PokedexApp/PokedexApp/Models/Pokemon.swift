//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let moves: [PokemonLearnedMove]
    let species: NameURLStructure
    let types: [NameURLStructure]
    let stats: [PokemonStat]
}

struct NameURLStructure: Codable {
    let name: String
    let url: String
}

struct PokemonLearnedMove: Codable {
    let move: NameURLStructure
}

struct PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let statName: NameURLStructure
}
