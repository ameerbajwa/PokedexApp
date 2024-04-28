//
//  PokedexCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/11/24.
//

import Foundation
import UIKit

class PokedexCoordinator {
    var navigationController: UINavigationController
    let networkService: NetworkService
    let pokemonListViewModel: PokemonListViewModel
    let pokedexViewController: PokedexViewController
    
    init(service: NetworkService, navigationController: UINavigationController) {
        self.networkService = service
        self.navigationController = navigationController
        
        self.pokemonListViewModel = PokemonListViewModel(networkService: networkService)
        self.pokedexViewController = PokedexViewController(viewModel: pokemonListViewModel)
        self.pokedexViewController.coordinator = self
    }
    
    func start() {
        navigationController.pushViewController(pokedexViewController, animated: false)
    }
    
}
