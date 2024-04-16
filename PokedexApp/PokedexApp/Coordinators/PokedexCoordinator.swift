//
//  PokedexCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/11/24.
//

import Foundation

class PokedexCoordinator: CoordinatorProtocol {
    
    let networkService: NetworkService
    let pokemonListViewModel: PokemonListViewModel
    let pokedexViewController: PokedexViewController
    
    init(service: NetworkService) {
        self.networkService = service
        
        self.pokemonListViewModel = PokemonListViewModel(networkService: networkService)
        self.pokedexViewController = PokedexViewController(viewModel: pokemonListViewModel)
    }
    
    func start() {
        
    }
    
    func finish() {
        
    }
}
