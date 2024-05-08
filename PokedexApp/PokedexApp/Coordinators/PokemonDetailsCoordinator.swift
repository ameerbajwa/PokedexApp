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
    let detailsView: PokemonDetailsView
    let controller: PokemonDetailsViewController
    
    init(navigationController: UINavigationController, networkService: NetworkService, pokemonId: Int) {
        self.navigationController = navigationController
        self.networkService = networkService
        
        self.viewModel = PokemonDetailsViewModel(networkService: networkService, pokemonId: pokemonId)
        self.detailsView = PokemonDetailsView()
        self.controller = PokemonDetailsViewController(viewModel: viewModel, detailsView: detailsView)
        self.controller.coordinator = self
        print("PokemonDetailsViewController and associated services/views have been initialized")
    }
    
    func start() {
        navigationController.pushViewController(controller, animated: false)
        print("push PokemonDetailsViewController to the forefront")
    }
}
