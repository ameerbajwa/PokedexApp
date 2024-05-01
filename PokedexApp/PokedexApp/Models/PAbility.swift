//
//  PAbility.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/30/24.
//

import Foundation

class PAbility: PokemonSuperClass {
    let flavorTextEntries: [PFlavorTextEntry]
    
    private enum PAbilityKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PAbilityKeys.self)
        self.flavorTextEntries = try container.decode([PFlavorTextEntry].self, forKey: .flavorTextEntries)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: PAbilityKeys.self)
        try container.encode(self.flavorTextEntries, forKey: .flavorTextEntries)
    }
}
