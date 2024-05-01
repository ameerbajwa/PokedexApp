//
//  PokedexGenerationCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/10/24.
//

import Foundation
import UIKit

class PokedexGenerationCoordinator {
    var navigationController: UINavigationController

    let networkService: NetworkService
    var controller: PokedexGenerationViewController
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        self.networkService = NetworkService(urlSession: session, jsonDecoder: decoder)
        
        let view = PokedexGenerationView()
        self.controller = PokedexGenerationViewController(service: networkService, view: view)
        self.controller.coordinator = self
    }
    
    func start() {
        self.navigationController.pushViewController(controller, animated: false)
    }
    
    func selectPokemonGeneration(generation: Int) {
        let pokedexCoordinator = PokedexCoordinator(service: self.networkService, navigationController: self.navigationController, generation: generation)
        pokedexCoordinator.start()
    }
}
