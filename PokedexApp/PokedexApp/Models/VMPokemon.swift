//
//  VMPokemon.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/30/24.
//

import Foundation

class VMPokemon {
    var pokemonDetails: Pokemon
    var pokemonSpeciesDetails: PSpecies
    var pokedexConfiguration: PokedexConfiguration
    
    init(pokemon: Pokemon, pokemonSpecies: PSpecies, configuration: PokedexConfiguration) {
        self.pokemonDetails = pokemon
        self.pokemonSpeciesDetails = pokemonSpecies
        self.pokedexConfiguration = configuration
    }
}
