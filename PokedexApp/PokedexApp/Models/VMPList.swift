//
//  VMPList.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/26/24.
//

import Foundation

class VMPList {
    var pokemon: [VMPokemonInfo]
    
    init(pokemon: [VMPokemonInfo]) {
        self.pokemon = pokemon
    }
}

class VMPokemonInfo {
    var name: String
    var imageUrl: String
    var imageData: Data?
    var caught: Bool?
    
    init(name: String, imageUrl: String, imageData: Data? = nil, caught: Bool? = nil) {
        self.name = name
        self.imageUrl = imageUrl
        self.imageData = imageData
        self.caught = caught
    }
}
