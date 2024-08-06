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
    var imageUrl: String
    var image: UIImage?
    
    init(name: String, url: String, imageUrl: String, image: UIImage? = nil) {
        self.name = name
        self.url = url
        self.imageUrl = imageUrl
        self.image = image
    }
}
