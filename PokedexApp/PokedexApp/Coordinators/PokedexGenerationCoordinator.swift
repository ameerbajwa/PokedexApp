//
//  PokedexGenerationCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/10/24.
//

import Foundation

class PokedexGenerationCoordinator: CoordinatorProtocol {
    
    let networkService: NetworkService
    let pokedexGenerationViewController: PokedexGenerationViewController
    
    init() {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        self.networkService = NetworkService(urlSession: session, jsonDecoder: decoder)
        self.pokedexGenerationViewController = PokedexGenerationViewController(service: networkService)
    }
    
    func start() {}
    
    func finish() {}
    
}
