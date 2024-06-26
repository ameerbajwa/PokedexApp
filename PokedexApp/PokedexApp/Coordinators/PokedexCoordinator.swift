//
//  PokedexCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/11/24.
//

import Foundation
import UIKit

class PokedexCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController
    let networkService: NetworkService
    var viewModel: PokemonListViewModel
    var controller: PokedexViewController
    
    init(parentCoordinator: MainCoordinator, service: NetworkService, navigationController: UINavigationController, configuration: PokedexConfiguration) {
        self.parentCoordinator = parentCoordinator
        self.networkService = service
        self.navigationController = navigationController
        
        self.viewModel = PokemonListViewModel(networkService: networkService, configuration: configuration)
        self.controller = PokedexViewController(viewModel: viewModel)
    }
    
    func start() {
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    
    func goBackToPokedexGenerationList() {
        navigationController.popViewController(animated: false)
        parentCoordinator?.removeCoordinator()
    }
    
    func selectPokemon(configuration: PokedexConfiguration, with id: Int) {
        parentCoordinator?.createPokemonDetailsCoordinator(configuration: configuration, pokemonId: id)
    }
    
}
