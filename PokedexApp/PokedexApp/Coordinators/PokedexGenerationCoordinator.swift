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
    var pokedexGenerationViewController: PokedexGenerationViewController
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        self.networkService = NetworkService(urlSession: session, jsonDecoder: decoder)
        
        let pokedexGenerationView = PokedexGenerationView()
        self.pokedexGenerationViewController = PokedexGenerationViewController(service: networkService, view: pokedexGenerationView)
        self.pokedexGenerationViewController.coordinator = self
    }
    
    func start() {
        self.navigationController.pushViewController(pokedexGenerationViewController, animated: false)
    }
    
    func selectPokemonGeneration(generation: Int) {
        let pokedexCoordinator = PokedexCoordinator(service: self.networkService, navigationController: self.navigationController, generation: generation)
        pokedexCoordinator.start()
    }
}
