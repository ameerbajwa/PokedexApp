//
//  PokemonSuperClass.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/16/24.
//

import Foundation

class PokemonSuperClass: Codable {
    let id: Int
    let name: String
    
    enum PokemonSuperClassKeys: CodingKey {
        case id, name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonSuperClassKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PokemonSuperClassKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}

struct NameURLStructure: Codable {
    let name: String
    let url: String
}
