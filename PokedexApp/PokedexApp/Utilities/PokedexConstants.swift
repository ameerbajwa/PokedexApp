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
            return 20
        default:
            return 0
        }
    }
}


