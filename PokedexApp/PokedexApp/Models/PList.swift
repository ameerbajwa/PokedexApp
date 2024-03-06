//
//  PList.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/5/24.
//

import Foundation

class PList: Codable {
    let results: [PokemonNameURLStructure]
    
    private enum PListKey: String, CodingKey {
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PListKey.self)
        self.results = try container.decode([PokemonNameURLStructure].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PListKey.self)
        try container.encode(self.results, forKey: .results)
    }
}
