//
//  NetworkUtilities.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 9/23/24.
//

import Foundation

public enum PokeAPIUrls {
    case baseURL
    case spriteImageBaseURL
    
    var value: String {
        switch self {
        case .baseURL:
            return "https://pokeapi.co/api/"
        case .spriteImageBaseURL:
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon"
        }
    }
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

public enum PokeAPIEndpoint {
    case species
    case pokemon
    case pokemonList
    case move
    case type
    case generation
    case ability
    case versionGroup
    
    var value: String {
        switch self {
        case .species:
            return "pokemon-species/"
        case .pokemon:
            return "pokemon/"
        case .pokemonList:
            return "pokemon?"
        case .move:
            return "move/"
        case .type:
            return "type/"
        case .generation:
            return "generation/"
        case .ability:
            return "ability/"
        case .versionGroup:
            return "version-group/"
        }
    }
}

enum CompletionHandlerResponse {
    case success
    case failure
}
