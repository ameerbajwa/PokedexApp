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
    let viewModel: PokemonListViewModel
    let controller: PokedexViewController
    
    init(service: NetworkService, navigationController: UINavigationController, generation: Int) {
        self.networkService = service
        self.navigationController = navigationController
        
        self.viewModel = PokemonListViewModel(networkService: networkService, generation: generation)
        self.controller = PokedexViewController(viewModel: viewModel)
        self.controller.coordinator = self
    }
    
    func start() {
        navigationController.pushViewController(controller, animated: false)
    }
    
    func selectPokemon() {
        
    }
    
}
