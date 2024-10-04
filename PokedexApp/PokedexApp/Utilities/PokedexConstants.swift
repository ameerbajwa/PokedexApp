//
//  Constants.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

public enum PokedexConstants {
    case generations
    case versions
    
    var count: Int {
        switch self {
        case .generations:
            return 8
        case .versions:
            return 24
        }
    }
}

public enum PokedexChosenVersionCorrespondingGeneration: String, CaseIterable {
    case fireRed = "firered"
    case leafGreen = "leafgreen"
    case heartGold = "heartgold"
    case soulSilver = "soulsilver"
    case omegaRuby = "omega-ruby"
    case alphaSapphire = "alpha-sapphire"
    case brilliantDiamond = "brilliant-diamond"
    case shinyPearl = "shiny-pearl"
    
    var actualGeneration: Int? {
        switch self {
        case .fireRed, .leafGreen:
            return 1
        case .heartGold, .soulSilver:
            return 2
        case .omegaRuby, .alphaSapphire:
            return 3
        case .brilliantDiamond, .shinyPearl:
            return 4
        }
    }
}
