//
//  PokemonError.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 8/27/24.
//

import Foundation

enum PokemonError: Error {
    case noPokeAPIUrl
    case pokeAPIResponseError(error: Error)
    case decodingError
    
    var debugMessage: String {
        switch self {
        case .noPokeAPIUrl:
            return "API could not be sent. Please reach out to code owner."
        case .pokeAPIResponseError(_):
            return "Information was not able to be retrieved from PokeAPI site. Please try again later."
        case .decodingError:
            return "Information could not be decoded. Please reach out to code owner."
        }
    }
    
    var errorMessage: String {
        switch self {
        case .noPokeAPIUrl:
            return "Url could not be safely unwrapped"
        case .pokeAPIResponseError(let pokeAPIError):
            return pokeAPIError.localizedDescription
        case .decodingError:
            return "Check changes to model classes and PokeAPI responses"
        }
    }
}
