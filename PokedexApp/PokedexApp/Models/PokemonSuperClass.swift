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
    
    private enum PokemonSuperClassKeys: String, CodingKey {
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

class PokemonNameURLStructure: Codable {
    let name: String
    let url: String
    
    private enum PokemonNameURLStructureKeys: String, CodingKey {
        case name, url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonNameURLStructureKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PokemonNameURLStructureKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.url, forKey: .url)
    }
}

class PFlavorTextEntry: Codable {
    let flavorText: String
    let language: PokemonNameURLStructure
    let version: PokemonNameURLStructure
    
    enum PSpeciesFlavorTextEntryKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PSpeciesFlavorTextEntryKeys.self)
        self.flavorText = try container.decode(String.self, forKey: .flavorText)
        self.language = try container.decode(PokemonNameURLStructure.self, forKey: .language)
        self.version = try container.decode(PokemonNameURLStructure.self, forKey: .version)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PSpeciesFlavorTextEntryKeys.self)
        try container.encode(self.flavorText, forKey: .flavorText)
        try container.encode(self.language, forKey: .language)
        try container.encode(self.version, forKey: .version)
    }
}
