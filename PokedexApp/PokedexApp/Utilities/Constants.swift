//
//  Constants.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

public struct Constants {
    static let baseURL = "https://pokeapi.co/api/"
    static let firstGenerationPokemonListParameter = "?offset=0&limit=151"
}

public enum UrlVersion {
    case v1
    case v2
    
    var value: String {
        switch self {
        case .v1:
            return "v1/"
        case .v2:
            return "v2/"
        }
    }
}

enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

public enum Endpoint {
    case species
    case pokemon
    case move
    case type
    case stat
    
    var value: String {
        switch self {
        case .species:
            return "pokemon-species/"
        case .pokemon:
            return "pokemon/"
        case .move:
            return "move/"
        case .type:
            return "type/"
        case .stat:
            return "stat/"
        }
    }
}
