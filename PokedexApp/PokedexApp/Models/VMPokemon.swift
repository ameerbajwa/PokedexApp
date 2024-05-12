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
    
    init(pokemon: Pokemon, pokemonSpecies: PSpecies) {
        self.pokemonDetails = pokemon
        self.pokemonSpeciesDetails = pokemonSpecies
    }
}
