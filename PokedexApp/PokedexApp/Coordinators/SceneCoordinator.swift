//
//  SceneCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/10/24.
//

import Foundation
import UIKit

class SceneCoordinator: CoordinatorProtocol {
    let window: UIWindow?
    var pokedexGenerationCoordinator: PokedexGenerationCoordinator
    
    init(window: UIWindow?) {
        self.window = window
        
        self.pokedexGenerationCoordinator = PokedexGenerationCoordinator()
        self.pokedexGenerationCoordinator.start()
    }

    func start() {
        
    }
    
    func finish() {
        
    }
}
