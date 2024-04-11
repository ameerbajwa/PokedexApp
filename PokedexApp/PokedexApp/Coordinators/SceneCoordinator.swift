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
    
    let networkService: NetworkService
    let pokedexGenerationViewController: PokedexGenerationViewController

    init(window: UIWindow?) {
        self.window = window
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        self.networkService = NetworkService(urlSession: session, jsonDecoder: decoder)
        self.pokedexGenerationViewController = PokedexGenerationViewController(service: networkService)
    }

    func start() {
        guard let window = window else {
            return
        }

        window.rootViewController = self.pokedexGenerationViewController
        window.makeKeyAndVisible()
    }
    
    func finish() {}
}
