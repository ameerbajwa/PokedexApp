//
//  PokemonDetailsCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/29/24.
//

import Foundation
import UIKit

class PokemonDetailsCoordinator {
    var navigationController: UINavigationController
    let networkService: NetworkService
    
    let viewModel: PokemonDetailsViewModel
    let controller: PokemonDetailsViewController
    
    init(navigationController: UINavigationController, networkService: NetworkService, pokemonId: Int) {
        self.navigationController = navigationController
        self.networkService = networkService
        
        self.viewModel = PokemonDetailsViewModel(networkService: networkService, pokemonId: pokemonId)
        self.controller = PokemonDetailsViewController(viewModel: viewModel)
        self.controller.coordinator = self
    }
    
    func start() {
        navigationController.pushViewController(controller, animated: false)
    }
}
