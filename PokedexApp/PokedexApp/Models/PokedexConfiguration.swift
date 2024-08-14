//
//  PokedexConfiguration.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 5/12/24.
//

import Foundation

struct PokedexConfiguration {
    var region: String
    var versionGroups: [String]
    var generation: String
    var startingPokemonId: Int
    var endingPokemonId: Int
    var selectedPokemonId: Int?
    
    init(region: String, versionGroups: [String], generation: String, startingPokemonId: Int, endingPokemonId: Int, selectedPokemonId: Int? = nil) {
        self.region = region
        self.versionGroups = versionGroups
        self.generation = generation
        self.startingPokemonId = startingPokemonId
        self.endingPokemonId = endingPokemonId
        self.selectedPokemonId = selectedPokemonId
    }
}

struct NewPokedexConfiguration {
    var region: String
    var selectedGeneration: String
    var selectedVersion: String
    var startingPokemonId: Int
    var endingPokemonId: Int
    var selectedPokemonId: Int?
    
    init(region: String, selectedGeneration: String, selectedVersion: String, startingPokemonId: Int, endingPokemonId: Int, selectedPokemonId: Int? = nil) {
        self.region = region
        self.selectedGeneration = selectedGeneration
        self.selectedVersion = selectedVersion
        self.startingPokemonId = startingPokemonId
        self.endingPokemonId = endingPokemonId
        self.selectedPokemonId = selectedPokemonId
    }
}
