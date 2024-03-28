//
//  VMPList.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/26/24.
//

import Foundation
import UIKit

class VMPList {
    var pokemon: [VMPokemonInfo]
    
    init(pokemon: [VMPokemonInfo]) {
        self.pokemon = pokemon
    }
}

class VMPokemonInfo {
    var name: String
    var url: String
    var image: UIImage?
    var caught: Bool?
    
    init(name: String, url: String, image: UIImage? = nil, caught: Bool? = nil) {
        self.name = name
        self.url = url
        self.image = image
        self.caught = caught
    }
}
