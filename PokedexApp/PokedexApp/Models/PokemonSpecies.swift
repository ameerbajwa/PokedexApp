//
//  PokemonSpecies.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/10/24.
//

import Foundation

struct PokemonSpecies: Codable {
    let evolutionChain: PokemonSpeciesEvolutionChainUrl
    let evolvesFromSpecies: NameURLStructure
    let habtit: NameURLStructure
    let id: Int
    let name: String
}

struct PokemonSpeciesEvolutionChainUrl {
    let url: String
}
