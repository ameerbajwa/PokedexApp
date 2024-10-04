//
//  MainCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 5/11/24.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class MainCoordinator {
    var navigationController: UINavigationController
    
    let networkService: NetworkService
    
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        self.networkService = NetworkService(urlSession: session, jsonDecoder: decoder)
    }
    
    func createPokedexTitleCoordinator() {
        let pokedexTitleCoordinator = PokedexTitleCoordinator(navigationController: navigationController, parentCoordinator: self, networkService: networkService)
        childCoordinators.append(pokedexTitleCoordinator)
        pokedexTitleCoordinator.start()
    }
    
    func createPokedexCoordinator(configuration: PokedexConfiguration) {
        let pokedexCoordinator = PokedexCoordinator(parentCoordinator: self, service: networkService, navigationController: navigationController, configuration: configuration)
        childCoordinators.append(pokedexCoordinator)
        pokedexCoordinator.start()
    }
    
    func createPokemonDetailsCoordinator(configuration: PokedexConfiguration, pokemonId: Int) {
        let pokemonDetailsCoordinator = PokemonDetailsCoordinator(parentCoordinator: self, navigationController: navigationController, networkService: networkService, configuration: configuration, pokemonId: pokemonId)
        childCoordinators.append(pokemonDetailsCoordinator)
        pokemonDetailsCoordinator.start()
    }
    
    func removeCoordinator() {
        _ = childCoordinators.removeLast()
    }
}
